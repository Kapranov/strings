class HomeController < ApplicationController
  before_action :set_user,  only: [:show]

  def index
    @users = User.order_by(email: :desc)
    Rails.logger.info "The Full list users by completed!"
    render json: Oj.dump(json_for(@users, include: ['phones', 'cards'], meta: meta), mode: :compat)
    # binding.pry
  end

  def show
    @user = User.where(id: params[:id]).first
    if @user
      render json: Oj.dump(json_for(@user, include: ['cards', 'phones'], meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  private

  def set_user
    @user = User.where(id: params[:id]).first
  end
end
