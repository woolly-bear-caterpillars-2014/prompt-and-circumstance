class PromptsController < ApplicationController

  def index

  end

  def new
    @prompt = Prompt.new
  end

  def create
    @prompt = Prompt.create(prompt_params)
    redirect_to prompt_path(@prompt)
  end

  def show
    @prompt = Prompt.find(params[:id])
  end

  private
  def prompt_params
    params.require(:prompt).permit(:title, :description)
  end
end
