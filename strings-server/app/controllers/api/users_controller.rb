class API::UsersController < ApplicationController
  include ActionController::Serialization

  before_action :authenticate
  before_action :validate_token
  before_action :check_header
  before_action :restrict_access

  def index
    @users = User.all
    render :json => MultiJson.dump(json_for(@users), mode: :compat)
  end

  private

  def user_param
    params.required(:user).permit(
      :first_name,
      :last_name,
      :middle_name,
      :password,
      :apikey,
      :email,
      :description
    )
  end

  def restrict_access
    token = User.where(:apikey => params[:token])
    params[:token] = token
    if token.present?
      return headers['Authorization']
    else
      head :unauthorized
    end
  end
end
