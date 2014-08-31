class VotesController < ApplicationController


  # EDDIE:
  #we should use separate routes + controller actions for votes on Prompts and Responses - we'll handle prompts- take the responses

  ### Prompt Vote Create

  def createPromptVote
    @prompt = Prompt.find(params[:vote][:votable_id])

    if !session[:user_id]
      flash[:notice] = 'Must be logged in to vote! What are you trying to do you dirty vote scammer??'
    else
      @user = User.find(session[:user_id])
      @vote = @prompt.votes.new(vote_params)

      if Vote.check_against_duplicates(@user, @vote)
        @user.votes << @vote
        @prompt.update_score(@vote)
      else
        flash[:notice] = 'What are you trying to do you dirty vote scammer??'
      end
    end
    redirect_to prompt_path(@prompt)

  end

# You can only vote once or something.

  ### and for Responses
  def createResponseVote
  end

  private
  def vote_params
      params.require(:vote).permit(:polarity, :votable_id, :votable_type)
  end



end
