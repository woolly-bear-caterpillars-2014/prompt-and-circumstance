class PromptsController < ApplicationController

  def index
    @prompts = Prompt.order("created_at DESC")
  end

  def new
    return redirect_to '/', alert: "Login or Signup first" unless current_user
    @prompt = current_user.prompts.build
  end

  def create
    return redirect_to '/', alert: "Login or Signup first" unless current_user

    @prompt = current_user.prompts.build(prompt_params)
    if @prompt.save
      redirect_to prompt_path(@prompt)
    else
      flash[:notice] = 'Prompt Creation Failed, Please Try Again! '
      redirect_to new_prompt_path
    end
  end

  def show
    @prompt = Prompt.find(params[:id])
    @response = Response.new
  end

  private
  def prompt_params
    params.require(:prompt).permit(:title, :description)
  end

end
