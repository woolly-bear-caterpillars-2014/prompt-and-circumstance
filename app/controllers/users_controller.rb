class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render 'new'
    end
  end

  def login
    @user = User.find_by_email(user_params[:email])
    if @user.authenticate
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render #'login'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
