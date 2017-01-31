V ?= @
LOCALHOST := '127.0.0.1'
PORT := '3000'
VERSION := '0.0.1'
LOCALSERVER := 'http://api.dev.local:3000'
RUBYSERVICE := $(shell pgrep ruby)
NGINXSERVICE := $(shell pgrep nginx)
UNICORNSERVICE := $(shell pgrep unicorn)
THINSERVICE := $(shell pgrep thin)
SIDEKIQSERVICE := $(shell pgrep sidekiq)
REDISBROWSERSERVICE := $(shell pgrep puma)
DEVELOPMENT := 'development'
PRODUCTION := 'production'
TEST := 'test'

default:
	$(V)echo Please use \'make help\' or \'make ..any_parameters..\'

help:
	$(V)clear
	$(V)echo "\n\n\t Manual Makefile to start of the project:\n\n make start - Start App Development Environment.\n make test  - Start App Test Environment.\n"

kill_all:
	$(V)if [ "$(RUBYSERVICE)" ]; then killall ruby && echo "Running Ruby Service Killed"; else echo "No Running Ruby Service!"; fi
	$(V)if [ "$(NGINXSERVICE)" ]; then service nginx stop && echo "Running Nginx Service Killed"; else echo "No Running Nginx Service!"; fi
	$(V)if [ "$(REDISBROWSERSERVICE)" ]; then killall redis_browser && echo "Running Redis Browser Killed"; else echo "No Running Redis Browser!"; fi

kill_ruby:
	$(V)echo "\nChecking to see if RUBY process exists:\n"
	$(V)if [ "$(RUBYSERVICE)" ]; then killall ruby && echo "Running Ruby Service Killed"; else echo "No Running Ruby Service!"; fi

processes:
	$(V)ps aux | grep 'ruby' | awk '{print $2}' | xargs kill -9

nginx: kill_ruby
	$(V)if [ "$(RUBYSERVICE)" ]; then killall ruby && echo "Running Ruby Service Killed"; else echo "No Running Ruby Service!"; fi
	$(V)if [ "$(NGINXSERVICE)" ]; then service nginx stop && echo "Running Nginx Service Killed"; else echo "No Running Nginx Service!"; fi
	$(V)if [ "$(UNICORNSERVICE)" ]; then ps aux | grep 'unicorn' | awk '{print $2}' | xargs kill -9 && echo "Running Unicorn Service Killed"; else echo "No Running Unicorn Service!"; fi
	$(V)if [ "$(SIDEKIQSERVICE)" ]; then killall sidekiq && echo "Running Sidekiq Service Killed"; else echo "No Running Sidekiq Service!"; fi

bundle:
	$(V)bundle

clean:
	$(V)clear
	$(V)bundle exec rake tmp:clear
	$(V)bundle exec rake log:clear
	$(V)rake nobrainer:reset

start_redis_browser: kill_redis_browser
	$(V)redis-browser --config config/redis_browser.yml

kill_redis_browser:
	$(V)if [ "$(REDISBROWSERSERVICE)" ]; then killall redis_browser && echo "Running Redis Browser Killed"; else echo "No Running Redis Browser!"; fi

start_sidekiq:
	$(V)bundle exec sidekiq -C config/sidekiq.yml

kill_sidekiq:
	$(V)bundle exec sidekiqctl stop ./tmp/pids/sidekiq.pid

start_servers:
	$(V)sudo service redis_6379 start
	$(V)sudo service rethinkdb start

kill_servers:
	$(V)sudo service redis_6379 stop
	$(V)sudo service rethinkdb stop

create_index:
	$(V)rake nobrainer:sync_indexes

reset_db:
	$(V)rake nobrainer:reset

start_guard:
	$(V)bundle exec guard

brakeman:
	$(V)brakeman

server:
	$(V)ruby -run -e httpd . -p 3000

start_test: clean
	$(V)rake test

start: kill_ruby nginx clean bundle reset_db
	$(V)echo "\n\n\t  Start App $(DEVELOPMENT) Enviroment\n\n\t     $(LOCALSERVER)\n\n"
	$(V)foreman start web
