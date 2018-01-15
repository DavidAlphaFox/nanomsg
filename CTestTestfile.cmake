# CMake generated Testfile for 
# Source directory: /Users/david/Documents/workspace/erlang/nanomsg
# Build directory: /Users/david/Documents/workspace/erlang/nanomsg
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(inproc "/Users/david/Documents/workspace/erlang/nanomsg/inproc" "12100")
set_tests_properties(inproc PROPERTIES  TIMEOUT "5")
add_test(inproc_shutdown "/Users/david/Documents/workspace/erlang/nanomsg/inproc_shutdown" "12110")
set_tests_properties(inproc_shutdown PROPERTIES  TIMEOUT "5")
add_test(ipc "/Users/david/Documents/workspace/erlang/nanomsg/ipc" "12120")
set_tests_properties(ipc PROPERTIES  TIMEOUT "5")
add_test(ipc_shutdown "/Users/david/Documents/workspace/erlang/nanomsg/ipc_shutdown" "12130")
set_tests_properties(ipc_shutdown PROPERTIES  TIMEOUT "30")
add_test(ipc_stress "/Users/david/Documents/workspace/erlang/nanomsg/ipc_stress" "12140")
set_tests_properties(ipc_stress PROPERTIES  TIMEOUT "5")
add_test(tcp "/Users/david/Documents/workspace/erlang/nanomsg/tcp" "12150")
set_tests_properties(tcp PROPERTIES  TIMEOUT "5")
add_test(tcp_shutdown "/Users/david/Documents/workspace/erlang/nanomsg/tcp_shutdown" "12160")
set_tests_properties(tcp_shutdown PROPERTIES  TIMEOUT "120")
add_test(ws "/Users/david/Documents/workspace/erlang/nanomsg/ws" "12170")
set_tests_properties(ws PROPERTIES  TIMEOUT "5")
add_test(pair "/Users/david/Documents/workspace/erlang/nanomsg/pair" "12180")
set_tests_properties(pair PROPERTIES  TIMEOUT "5")
add_test(pubsub "/Users/david/Documents/workspace/erlang/nanomsg/pubsub" "12190")
set_tests_properties(pubsub PROPERTIES  TIMEOUT "5")
add_test(reqrep "/Users/david/Documents/workspace/erlang/nanomsg/reqrep" "12200")
set_tests_properties(reqrep PROPERTIES  TIMEOUT "5")
add_test(pipeline "/Users/david/Documents/workspace/erlang/nanomsg/pipeline" "12210")
set_tests_properties(pipeline PROPERTIES  TIMEOUT "5")
add_test(survey "/Users/david/Documents/workspace/erlang/nanomsg/survey" "12220")
set_tests_properties(survey PROPERTIES  TIMEOUT "5")
add_test(bus "/Users/david/Documents/workspace/erlang/nanomsg/bus" "12230")
set_tests_properties(bus PROPERTIES  TIMEOUT "5")
add_test(async_shutdown "/Users/david/Documents/workspace/erlang/nanomsg/async_shutdown" "12240")
set_tests_properties(async_shutdown PROPERTIES  TIMEOUT "30")
add_test(block "/Users/david/Documents/workspace/erlang/nanomsg/block" "12250")
set_tests_properties(block PROPERTIES  TIMEOUT "5")
add_test(term "/Users/david/Documents/workspace/erlang/nanomsg/term" "12260")
set_tests_properties(term PROPERTIES  TIMEOUT "5")
add_test(timeo "/Users/david/Documents/workspace/erlang/nanomsg/timeo" "12270")
set_tests_properties(timeo PROPERTIES  TIMEOUT "5")
add_test(iovec "/Users/david/Documents/workspace/erlang/nanomsg/iovec" "12280")
set_tests_properties(iovec PROPERTIES  TIMEOUT "5")
add_test(msg "/Users/david/Documents/workspace/erlang/nanomsg/msg" "12290")
set_tests_properties(msg PROPERTIES  TIMEOUT "5")
add_test(prio "/Users/david/Documents/workspace/erlang/nanomsg/prio" "12300")
set_tests_properties(prio PROPERTIES  TIMEOUT "5")
add_test(poll "/Users/david/Documents/workspace/erlang/nanomsg/poll" "12310")
set_tests_properties(poll PROPERTIES  TIMEOUT "5")
add_test(device "/Users/david/Documents/workspace/erlang/nanomsg/device" "12320")
set_tests_properties(device PROPERTIES  TIMEOUT "5")
add_test(device4 "/Users/david/Documents/workspace/erlang/nanomsg/device4" "12330")
set_tests_properties(device4 PROPERTIES  TIMEOUT "5")
add_test(device5 "/Users/david/Documents/workspace/erlang/nanomsg/device5" "12340")
set_tests_properties(device5 PROPERTIES  TIMEOUT "5")
add_test(device6 "/Users/david/Documents/workspace/erlang/nanomsg/device6" "12350")
set_tests_properties(device6 PROPERTIES  TIMEOUT "5")
add_test(device7 "/Users/david/Documents/workspace/erlang/nanomsg/device7" "12360")
set_tests_properties(device7 PROPERTIES  TIMEOUT "30")
add_test(emfile "/Users/david/Documents/workspace/erlang/nanomsg/emfile" "12370")
set_tests_properties(emfile PROPERTIES  TIMEOUT "5")
add_test(domain "/Users/david/Documents/workspace/erlang/nanomsg/domain" "12380")
set_tests_properties(domain PROPERTIES  TIMEOUT "5")
add_test(trie "/Users/david/Documents/workspace/erlang/nanomsg/trie" "12390")
set_tests_properties(trie PROPERTIES  TIMEOUT "5")
add_test(list "/Users/david/Documents/workspace/erlang/nanomsg/list" "12400")
set_tests_properties(list PROPERTIES  TIMEOUT "5")
add_test(hash "/Users/david/Documents/workspace/erlang/nanomsg/hash" "12410")
set_tests_properties(hash PROPERTIES  TIMEOUT "5")
add_test(stats "/Users/david/Documents/workspace/erlang/nanomsg/stats" "12420")
set_tests_properties(stats PROPERTIES  TIMEOUT "5")
add_test(symbol "/Users/david/Documents/workspace/erlang/nanomsg/symbol" "12430")
set_tests_properties(symbol PROPERTIES  TIMEOUT "5")
add_test(separation "/Users/david/Documents/workspace/erlang/nanomsg/separation" "12440")
set_tests_properties(separation PROPERTIES  TIMEOUT "5")
add_test(zerocopy "/Users/david/Documents/workspace/erlang/nanomsg/zerocopy" "12450")
set_tests_properties(zerocopy PROPERTIES  TIMEOUT "5")
add_test(shutdown "/Users/david/Documents/workspace/erlang/nanomsg/shutdown" "12460")
set_tests_properties(shutdown PROPERTIES  TIMEOUT "5")
add_test(cmsg "/Users/david/Documents/workspace/erlang/nanomsg/cmsg" "12470")
set_tests_properties(cmsg PROPERTIES  TIMEOUT "5")
add_test(bug328 "/Users/david/Documents/workspace/erlang/nanomsg/bug328" "12480")
set_tests_properties(bug328 PROPERTIES  TIMEOUT "5")
add_test(ws_async_shutdown "/Users/david/Documents/workspace/erlang/nanomsg/ws_async_shutdown" "12490")
set_tests_properties(ws_async_shutdown PROPERTIES  TIMEOUT "5")
add_test(reqttl "/Users/david/Documents/workspace/erlang/nanomsg/reqttl" "12500")
set_tests_properties(reqttl PROPERTIES  TIMEOUT "10")
add_test(surveyttl "/Users/david/Documents/workspace/erlang/nanomsg/surveyttl" "12510")
set_tests_properties(surveyttl PROPERTIES  TIMEOUT "10")
subdirs(src)