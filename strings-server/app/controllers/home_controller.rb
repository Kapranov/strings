class HomeController < ApplicationController
  before_action :set_cache_headers, only: [:index]
  before_action :set_user,  only: [:show]

  def index
    @users = User.order_by(email: :desc)
    Rails.logger.info "The Full list users by completed!"
    if @users
      render json: Oj.dump(json_for(@users, include: ['phones', 'cards'], meta: meta), mode: :compat)
      # binding.pry
    else
      return head :unauthorized
    end
  end

  def show
    if @user
      render json: Oj.dump(json_for(@user, include: ['phones', 'cards'], meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  private

  def set_user
    @user = User.where(id: params[:id]).first
  end

  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
