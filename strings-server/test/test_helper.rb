ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"

Minitest::Reporters.use! [
  Minitest::Reporters::DefaultReporter.new(:color => true),
  Minitest::Reporters::SpecReporter.new,
  Minitest::Reporters::ProgressReporter.new,
  Minitest::Reporters::JUnitReporter.new,
  Minitest::Reporters::MeanTimeReporter.new,
  Minitest::Reporters::HtmlReporter.new
]

class ActiveSupport::TestCase
  include Rack::Test::Methods

  # fixtures :all
end
