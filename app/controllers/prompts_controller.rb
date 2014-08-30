class PromptsController < ApplicationController

  def index
    @prompts = Prompt.order("created_at DESC")
  end

  def new
    redirect_to '/' unless session[:user_id]
    @prompt = Prompt.new
  end

  def create
    @prompt = Prompt.new(prompt_params)
    if @prompt.save
      redirect_to prompt_path(@prompt)
    else
      render :new
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
