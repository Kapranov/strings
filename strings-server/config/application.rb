require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module StringsServer
  class Application < Rails::Application

    config.api_only = true
    config.middleware.use Rack::Deflater
    config.middleware.delete ActionDispatch::RequestId
    config.middleware.delete Rack::Lock
    config.active_job.queue_adapter = :sidekiq
    config.time_zone = 'Eastern Time (US & Canada)'
    config.exceptions_app = self.routes
    config.autoload_paths << Rails.root.join('lib')

    config.generators do |g|
      g.test_framework :minitest, spec: true, fixture: true, fixture_replacement: :factory_girl
    end
  end
end
