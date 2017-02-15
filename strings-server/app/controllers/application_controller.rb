class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActiveModel::Serializers::JSON

  TOKEN = 'secret'
  AUTHS = { 'me' => '@home', 'you' => '@work' }

  before_action :authenticate_http
  before_action :authenticate_token, except: [ :index ]
  after_action  :set_online

  def append_info_to_payload(payload)
    super
    payload[:host] = request.host
  end

  def index
    @tokens = Token.all
    # render json: @tokens
    # render json: MultiJson.dump(json_for(@tokens), mode: :compat)
    # render json: Oj.dump(@tokens.first, mode: :compat)
    render html: "<strong>Everyone can see me!</strong>".html_safe
  end

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    data = ActiveModelSerializers::SerializableResource.new(target, options)
    logger.debug("Application as_json called!")
    super
  end

  def meta(options)
    { copyright: "© #{Time.now.year} LugaTeX - WeblogAsService, Inc." }
  end

  private

  def set_online
    $redis.set("hello", "Application was connected to Redis!")
  end

  def authenticate_http
    if Rails.env == 'development' && request.remote_addr !~ /^192.168.0.\d{1,3}$/
      authenticate_or_request_with_http_basic("Application") do |name, password|
        @name = Token.where.first[:username]
        @password = Token.where.first[:password]
        @name = name && @password = password
        # AUTHS.has_key?(name) && AUTHS[name] == password
      end
    end
  end

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(
       ::Digest::SHA256.hexdigest(token),
       ::Digest::SHA256.hexdigest(TOKEN)
      )
    end
  end
end
