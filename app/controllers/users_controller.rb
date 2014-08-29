class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find(params[:user_id])
    @response = @user.responses.new(response_params)

    if @response.save
      redirect_to @user
    else
      render :template => 'users/show'
    end
  end

  private
  def response_params
    params.require(:response).permit(:body)
  end
end
