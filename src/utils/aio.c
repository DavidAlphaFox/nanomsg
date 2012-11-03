/*
    Copyright (c) 2012 250bpm s.r.o.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom
    the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.
*/

#include "aio.h"

#if defined SP_HAVE_WINDOWS

#include "err.h"
#include "fast.h"

void sp_aio_init (struct sp_aio *self)
{
    self->hndl = CreateIoCompletionPort (INVALID_HANDLE_VALUE, NULL, 0, 0);
    win_assert (self->hndl);
}

void sp_aio_term (struct sp_aio *self)
{
    BOOL brc;

    brc = CloseHandle (self->hndl);
    win_assert (brc);
}

void sp_aio_post (struct sp_aio *self, int op, void *arg)
{
    BOOL brc;

    brc = PostQueuedCompletionStatus (self->hndl, (DWORD) op,
        (ULONG_PTR) arg, NULL);
    win_assert (brc);
}

int sp_aio_wait (struct sp_aio *self, int timeout, int *op, void **arg)
{
    BOOL brc;
    DWORD nbytes;
    ULONG_PTR key;
    LPOVERLAPPED olpd;

    brc = GetQueuedCompletionStatus (self->hndl, &nbytes, &key,
        &olpd, timeout < 0 ? INFINITE : timeout);
    if (sp_slow (!brc && !olpd))
        return -ETIMEDOUT;
    win_assert (brc);
    *op = (int) nbytes;
    *arg = (void*) key;

    return 0;
}

#else

#include "alloc.h"
#include "usock.h"
#include "fast.h"
#include "err.h"

#define SP_CP_INITIAL_CAPACITY 64

void sp_aio_init (struct sp_aio *self)
{
    sp_mutex_init (&self->sync, 0);
    sp_poller_init (&self->poller);
    sp_eventfd_init (&self->eventfd);
    sp_poller_add_fd (&self->poller, sp_eventfd_getfd (&self->eventfd),
        &self->evhndl);
    sp_poller_set_in (&self->poller, &self->evhndl);
    self->capacity = SP_CP_INITIAL_CAPACITY;
    self->head = 0;
    self->tail = 0;
    self->items = sp_alloc (self->capacity * sizeof (struct sp_aio_item));
    alloc_assert (self->items);
}

void sp_aio_term (struct sp_aio *self)
{
    sp_free (self->items);
    sp_poller_rm_fd (&self->poller, &self->evhndl);
    sp_eventfd_term (&self->eventfd);
    sp_poller_term (&self->poller);
    sp_mutex_term (&self->sync);
}

void sp_aio_post (struct sp_aio *self, int op, void *arg)
{
    int empty;

    sp_mutex_lock (&self->sync);

    /*  Fill in new item in the circular buffer. */
    self->items [self->tail].op = op;
    self->items [self->tail].arg = arg;

    /*  Move tail by 1 position. */
    empty = self->tail == self->head ? 1 : 0;
    self->tail = (self->tail + 1) % self->capacity;

    /*  If the capacity of the circular buffer is exhausted, allocate some
        more memory. */
    if (sp_slow (self->head == self->tail)) {
        self->items = sp_realloc (self->items,
            self->capacity * 2 * sizeof (struct sp_aio_item));
        alloc_assert (self->items);
        memcpy (self->items + self->capacity, self->items,
            self->tail * sizeof (struct sp_aio_item));
        self->tail += self->capacity;
        self->capacity *= 2;
    }
    
    if (empty)
        sp_eventfd_signal (&self->eventfd);

    sp_mutex_unlock (&self->sync);
}

int sp_aio_wait (struct sp_aio *self, int timeout, int *op, void **arg)
{
    int rc;
    int event;
    struct sp_poller_hndl *hndl;

    /*  If there's an item available, return it. */
    sp_mutex_lock (&self->sync);
    if (sp_fast (self->head != self->tail)) {
        *op = self->items [self->head].op;
        *arg = self->items [self->head].arg;
        self->head = (self->head + 1) % self->capacity;
        if (self->head == self->tail)
           sp_eventfd_unsignal (&self->eventfd);
        sp_mutex_unlock (&self->sync);
        return 0;
    }
    sp_mutex_unlock (&self->sync);

    /*  Wait for new item. */
    rc = sp_poller_wait (&self->poller, timeout, &event, &hndl);
    if (sp_slow (rc == -ETIMEDOUT || rc == -EINTR))
        return rc;
    errnum_assert (rc == 0, -rc);

    /*  TODO */
    sp_assert (hndl == &self->evhndl);

    /*  If there's an item available now, return it. */
    sp_mutex_lock (&self->sync);
    if (sp_fast (self->head != self->tail)) {
        *op = self->items [self->head].op;
        *arg = self->items [self->head].arg;
        self->head = (self->head + 1) % self->capacity;
        if (self->head == self->tail)
           sp_eventfd_unsignal (&self->eventfd);
        sp_mutex_unlock (&self->sync);
        return 0;
    }
    sp_mutex_unlock (&self->sync);

    /*  Spurious wake-up. */
    return -ETIMEDOUT;
}

void sp_aio_register_usock (struct sp_aio *self, struct sp_usock *usock)
{
#if defined SP_HAVE_WINDOWS
    HANDLE cp;

    cp = CreateIoCompletionPort ((HANDLE) usock->s, self->hndl,
        (ULONG_PTR) NULL, 0);
    sp_assert (cp);
#else
    sp_assert (!usock->aio);
    usock->aio = self;
#endif
}

#endif
