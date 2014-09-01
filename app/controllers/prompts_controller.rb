class PromptsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def index
    @prompts = Prompt.order("created_at DESC")
  end

  def index_hotness
    @prompts = Prompt.order('hotness DESC')
    render :index
  end

  def new
    #return redirect_to root_path, alert: "Login or Signup first" unless current_user
    @prompt = current_user.prompts.build
  end

  def create
    #return redirect_to root_path, alert: "Login or Signup first" unless current_user

    @prompt = current_user.prompts.build(prompt_params)
    if @prompt.save
      redirect_to prompt_path(@prompt)
    else
      redirect_to new_prompt_path, :alert => @prompt.errors.full_messages.join(". ")
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
