class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActiveModel::Serializers::JSON

  # include ActionController::Rendering
  # include ActionController::MimeResponds
  # include AbstractController::Callbacks
  # append_view_path "#{Rails.root}/app/views"

  http_basic_authenticate_with name: "kapranov", password: "12345678", except: :index

  TOKEN = "secret"

  before_action :authenticate, except: [ :index ]
  # before_action :authorize!
  after_action :set_online

  def append_info_to_payload(payload)
    super
    payload[:host] = request.host
    # payload[:username] = current_user.try(:username)
  end

  def index
    render plain: "Everyone can see me!"
  end

  def meta(options)
    { copyright: "© #{Time.now.year} LugaTeX - WeblogAsAService, Inc." }
  end

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    data = ActiveModelSerializers::SerializableResource.new(target, options)
  end

  protected

    def authenticate
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
      end
    end

    def render_unauthorized(realm = "Application")
      self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
      render json: 'Bad credentials', status: :unauthorized
    end

    def authorize!
      hdr = request.headers["Authorization"]
      if hdr && hdr =~ /\AToken\s+(token="?)?(.+?)"?\s*\z/
        return true if valid_apikey?($2)
      end

      render(status: :unauthorized, json:{errors:[{
        status:401, code:"unauthorized", title:"Unauthorized"
      }]})
    end

    def valid_apikey?(key)
      #@user = User.find_by(api_key:key)
      #!!@user # Make boolean
    end

  private

    def set_online
      $redis.set("hello", "Application was connected to Redis!")
    end

    def authenticate
       authenticate_or_request_with_http_token do |token, options|
         ActiveSupport::SecurityUtils.secure_compare(
           ::Digest::SHA256.hexdigest(token),
           ::Digest::SHA256.hexdigest(TOKEN)
         )
       end
    end
end
