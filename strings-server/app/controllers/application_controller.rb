class ApplicationController < ActionController::API
  include ActiveModel::Serializers::JSON

  after_action :set_online

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    data = ActiveModelSerializers::SerializableResource.new(target, options)
  end

  private

  def set_online
    $redis.set("test_key", "Application was connected to Redis!")
  end
end
