class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActiveModel::Serializers::JSON

  after_action  :set_online

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    data = ActiveModelSerializers::SerializableResource.new(target, options)
  end

  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer, meta: default_meta
  end

  def default_meta
    { licence: 'CC-0', authors: ['LugaTeX Inc.'], logged_in: Token.first[:username] ? true : false }
  end

  def meta(options)
    { copyright: "© #{Time.now.year} LugaTeX -  LaTeX Project Public License (LPPL)." }
  end

  private

  def set_online
    $redis.set("hello", "Application was connected to Redis!")
  end
end
