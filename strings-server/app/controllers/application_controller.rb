class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActiveModel::Serializers::JSON

  TOKEN = 'secret'
  ACCESS = { 'user1' => 'Tamron', 'user2' => 'Hall' }

  # before_action :authenticate_http
  before_action :authenticate
  before_action :validate_token
  before_action :check_header
  after_action  :set_online

  def append_info_to_payload(payload)
    super
    payload[:host] = request.host
  end

  def index
    # @tokens = Token.all
    # render json: @tokens, status: :ok, meta: default_meta
    # render json: MultiJson.dump(json_for(@tokens, status: :ok, meta: default_meta), mode: :compat)
    # render json: Oj.dump(@tokens.first, mode: :compat)
    # render html: "<strong>Everyone can see me!</strong>".html_safe
    render text: "Everyone can see me!"
  end

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    data = ActiveModelSerializers::SerializableResource.new(target, options)
    # logger.debug("Application as_json called!")
  end

  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer, meta: default_meta
  end

  def default_meta
    {
      licence: 'CC-0',
      authors: ['LugaTeX Inc.'],
      logged_in: Token.first[:username] ? true : false
    }
  end

  def meta(options)
    { copyright: "© #{Time.now.year} LugaTeX -  LaTeX Project Public License (LPPL)." }
  end

  private

  def set_online
    $redis.set("hello", "Application was connected to Redis!")
  end

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_http
    if Rails.env == 'development' && request.remote_addr !~ /^192.168.0.\d{1,3}$/
      authenticate_or_request_with_http_basic("Application") do |name, password|
        @name = Token.where.first[:username]
        @password = Token.where.first[:password]
        @name = name && @password = password
        # ACCESS.has_key?(name) && ACCESS[name] == password
      end
    end
  end

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      apikey = Token.where.first[:apikey]
      ActiveSupport::SecurityUtils.secure_compare(
       ::Digest::SHA256.hexdigest(token),
       ::Digest::SHA256.hexdigest(apikey)
      )
    end
  end

  def check_header
    if ['POST','PUT','PATCH'].include? request.method
      if request.content_type != "application/vnd.api+json"
        head 406 and return
      end
    end
  end

  def validate_token
    token = request.headers["Authorization"]
    return unless token
    apikey = Token.where.first[:apikey]
    updated_at = Token.where.first[:updated_at]
    apikey = token
    return unless apikey
    if 15.minutes.ago < updated_at
      token.touch
      @token = token
    end
  end

  #def validate_token
  #  apikey = request.headers["Authorization"]
  #  @token = Token.where.first[:apikey] if apikey

  #  unless @token
  #    head :bad_request
  #    return false
  #  end
  #end

  def render_unauthorized(realm=nil)
    if realm
      # self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")
    end
    render json: 'Bad credentials', status: 401
  end
end
