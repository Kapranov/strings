class ApplicationJob < ActiveJob::Base
  self.queue_adapter = :sidekiq
  queue_as :default

  before_enqueue do |job|
  end

  around_perform do |job, block|
    block.call
  end

  def perform
  end
end
