namespace :cache do
  namespace :clear do
    REDIS_CLEAR_BATCH_SIZE = 1000
    REDIS_SCAN_START_STOP = '0'

    desc "Strings | Clear redis cache"
    task redis: :environment do
      StringsServer::Redis.with do |redis|
        cursor = REDIS_SCAN_START_STOP
        loop do
          cursor, keys = redis.scan(
            cursor,
            match: "#{StringsServer::Redis::CACHE_NAMESPACE}*",
            count: REDIS_CLEAR_BATCH_SIZE
          )

          redis.del(*keys) if keys.any?

          break if cursor == REDIS_SCAN_START_STOP
        end
      end
    end

    desc "Strings | Clear database cache (in the background)"
    task db: :environment do
      ClearDatabaseCacheWorker.perform_async
    end

    task all: [:db, :redis]
  end

  task clear: 'cache:clear:all'
end
