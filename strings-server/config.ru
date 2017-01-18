require_relative 'config/environment'

run Rails.application
use Rack::Attack
