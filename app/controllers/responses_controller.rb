class ResponsesController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def create
    @prompt = Prompt.find(params[:prompt_id])
    @response = @prompt.responses.new(response_params)
    @response.user_id = current_user.id

    if @response.save
      redirect_to @prompt
    else
      render :template => 'prompts/show'
    end
  end

  private
  def response_params
    params.require(:response).permit(:body)
  end

end
