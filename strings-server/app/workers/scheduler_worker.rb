class SchedulerWorker
  include Sidekiq::Worker

  def perform
    puts 'Hello world'
  end
end

SchedulerWorker.perform_async()
