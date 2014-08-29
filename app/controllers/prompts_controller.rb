class PromptsController < ApplicationController

  def index
    @prompts = Prompt.order("created_at DESC")
  end

  def new
    if session[:prompt]
      @prompt = Prompt.new(session[:prompt])
      session[:prompt] = nil
    else
      @prompt = Prompt.new
    end
  end

  def create
    @prompt = Prompt.new(prompt_params)
    if @prompt.save
      flash.clear
      redirect_to prompt_path(@prompt)
    else
      session[:prompt] = prompt_params
      redirect_to new_prompt_path, notice: 'Invalid Prompt Submission, Please Try Again!'
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
