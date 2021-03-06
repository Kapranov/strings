require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"
require "./lib/middleware/catch_json_parse_errors.rb"

Bundler.require(*Rails.groups)

module StringsServer
  class Application < Rails::Application
    config.api_only = true
    config.exceptions_app = self.routes
    config.time_zone = 'Eastern Time (US & Canada)'
    config.debug_exception_response_format = :api
    config.active_job.queue_adapter = :sidekiq
    # config.eager_load_paths << Rails.root.join('lib', 'utils', 'custom_formatter.rb')
    config.eager_load_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('utils')
    config.eager_load_paths << Rails.root.join('custom_formatter.rb')
    config.autoload_paths += %W( #{config.root}/app/decorators)

    config.action_controller.perform_caching = true
    config.cache_store = :redis_store, Rails.application.secrets.redis_cache, { expires_in: 90.minutes }
    config.middleware.use Rack::Throttle::Interval, :min => 3.0, :cache => Redis.new, :key_prefix => :throttle

    # config.middleware.delete ActionDispatch::Static
    # config.middleware.delete ActionDispatch::Executor
    # config.middleware.delete ActionDispatch::RequestId
    # config.middleware.delete ActionDispatch::ShowExceptions
    # config.middleware.delete ActionDispatch::DebugExceptions
    # config.middleware.delete ActionDispatch::RemoteIp
    # config.middleware.delete ActionDispatch::Reloader
    # config.middleware.delete ActionDispatch::Callbacks
    # config.middleware.delete Rack::ConditionalGet
    # config.middleware.delete Rack::Cors
    # config.middleware.delete Rack::ETag
    # config.middleware.delete Rack::Head
    # config.middleware.delete Rack::Sendfile
    # config.middleware.delete Rails::Rack::Logger

    #config.middleware.delete Rack::Attack
    #config.middleware.delete Rack::Runtime
    #config.middleware.delete Rack::Sendfile
    #config.middleware.delete Rack::MethodOverride
    #config.middleware.delete ActionDispatch::Cookies
    #config.middleware.delete ActionDispatch::Session::CookieStore
    #config.middleware.delete ActionDispatch::Flash

    config.middleware.insert_before Rack::Head, CatchJsonParseErrors

    config.lograge.keep_original_rails_log = true
    config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/#{Rails.env}_lograge.log"
    config.lograge.formatter = ->(data) { "Called #{data[:controller]}" }
    # config.lograge.formatter = Lograge::Formatters::Json.new
    # config.lograge.formatter = Lograge::Formatters::KeyValue.new
    # config.lograge.ignore_actions = ['HomeController#index', 'AController#an_action']
    # config.lograge.ignore_custom = lambda do |event|
    #   # return true here if you want to ignore based on the event
    # end
    config.lograge.custom_options = lambda do |event|
      {:time => event.time, :search_engine => event.payload[:search_engine], :user_agent => event.payload[:user_agent]}
    end

    initializer :regenerate_require_cache, before: :load_environment_config do
      Bootscale.regenerate
    end

    config.generators do |g|
      g.factory_girl true
      # For Minitest
      # g.test_framework :minitest, spec: false, fixture: false
      # g.test_framework :minitest, spec: true
      # For RSpec
      g.test_framework :rspec, fixtures: false
      g.helper false
      g.decorator false
      g.controller assets: false
    end

    def generate_random_values
      10.times.each_with_object({}) do |number, acc|
        index = sprintf "%02d", number

        acc[index] = SecureRandom.hex(64)
      end
    end

    ["keys", "salts"].each do |filename|
      my_secrets = {
        development: generate_random_values,
        test:        generate_random_values
      }
      File.write Rails.root.join("config", "secret_#{filename}.yml"), my_secrets.to_yaml
    end

    encryption_type = "KEY"
    puts 10.times.each_with_object({}) do |number, acc|
      index = sprintf "%02d", number

      acc[index] = %Q{<%= ENV["MY_SECRET_#{encryption_type}_#{index}\"] %>}
    end

  end
end
