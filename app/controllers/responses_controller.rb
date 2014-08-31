class ResponsesController < ApplicationController
  def create
    return redirect_to '/', alert: "Login or Signup first" unless current_user
    @prompt = Prompt.find(params[:prompt_id])
    @response = Response.new(response_params)
    @response.user_id = current_user.id
    @response.prompt_id = @prompt.id

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
