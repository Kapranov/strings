class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if params[:password] == params[:password_confirmation]
      user.password = params[:password]
      if user.save
        jwt = Auth.issue({user: user.id})
        render json: {jwt: jwt}
      else
        render json: {:errors=>
         [{:detail=>"incorrect email or password",
           :source=>{:pointer=>"user/err_type"}}
         ]}, status: 404
      end
    else
      render json: {:errors=>
       [{:detail=>"incorrect email or password",
         :source=>{:pointer=>"user/err_type"}}
       ]}, status: 404
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
