namespace :hello do
  namespace :access do

    desc "Strings | Here’s an access the values in the redis server"
    task redis: :environment do
      $redis.set("test_key", "Hello World!")
      $redis.get("test_key")
    end

    desc "Strings | Clears currently active database (in the background)"
    task db: :environment do
      #ClearDatabaseCacheWorker.perform_async
      $redis.flushdb
    end

    desc "Strings | Clears all the existing databases (in the background)"
    task clear: :environment do
      $redis.flushall
    end

    task all: [:clear, :db, :redis]
  end

  task access: 'hello:access:all'
end
