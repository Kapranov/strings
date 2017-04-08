#!/usr/bin/env bash

clear

progress-bar() {
  local duration=${1}

  already_done() { for ((done=0; done<elapsed; done=done+1)); do printf "▇"; done }
  remaining() { for ((remain=elapsed; remain<duration; remain=remain+1)); do printf " "; done }
  percentage() { printf "| %s%%" $(( (elapsed*100)/(duration*100)/100 )); }
  clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=duration; elapsed=elapsed+1 )); do
    already_done; remaining; percentage
    sleep 1
    clean_line
  done
  clean_line
}

# until echo -en "\n\n\tWill clear directories - Please Wait ...!\n\n"; progress-bar 20; do

echo -en "\n\n\tPLEASE WAIT CLEAR LOG FILES...\n\n"

until ./lib/bar; rake nobrainer:sync_indexes nobrainer:reset clear:clear; do
  echo -en "\n\n\tDOWN!\n\n"
done

echo -en "\n\n\tStart localhost Server\n\n"
RUBY_GC_TOKEN=bd087c6fe87a174714f92cefc5878623 bundle exec rails s -b api.dev.local
