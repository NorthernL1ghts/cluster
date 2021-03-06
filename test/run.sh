#!/bin/sh

rm -f test/pids/*.pid
rm -f test/*.sock test/support/*.sock
rm -f test/logs/*.log
rm -f test/logs/nested/*.log

clean() {
  killall -KILL node &> /dev/null
}

clean
echo

files=test/test.*.js
for file in $files; do
  printf "\033[90m   ${file#test/}\033[0m "
  node $@ $file && echo "\033[36m✓\033[0m"
  test $? -eq 0 || exit $?
done
echo
