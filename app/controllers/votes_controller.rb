class VotesController < ApplicationController

  # EDDIE:
  #we should use separate routes + controller actions for votes on Prompts and Responses - we'll handle prompts- take the responses

  ### Prompt Vote Create
  # TODO: Fat, not DRY controllers here. Refactor both these into a single method, and move logic into helper methods

  def createPromptVote
    @prompt = Prompt.find(params[:vote][:votable_id])
    @vote = @prompt.votes.new(vote_params)

    respond_to do |format|
      if !session[:user_id]
        format.html {
          flash[:alert] = 'Must be logged in to vote! What are you trying to do you dirty vote scammer??'
          return redirect_to root_path
        }
        return format.js
      end

      @user = User.find(session[:user_id])
      @vote.user_id = @user.id

      if @vote.save
        @prompt.update_score(@vote)
        format.html { redirect_to prompt_path(@prompt) }
        format.js
      else
        format.html {
          flash[:alert] = 'What are you trying to do you dirty vote scammer??'
          redirect_to prompt_path(@prompt)
        }
        format.js
      end

    end
  end

# You can only vote once or something.

  ### and for Responses
  def createResponseVote
    @response = Response.find([params[:vote][:votable_id]]).first
    @vote = @response.votes.new(vote_params)

    respond_to do |format|
      if !session[:user_id]
        format.html{
          flash[:alert] = 'Must be logged in to vote! What are you trying to do you dirty vote scammer??'
          return redirect_to root_path
        }

        return format.js
      end

      @user = User.find(session[:user_id])
      @vote.user_id = @user.id

      if @vote.save
        @response.upvote(@vote)
        format.html { redirect_to prompt_path(@prompt) }
        format.js
      else
        format.html {
        flash[:alert] = 'What are you trying to do you dirty vote scammer??'
        redirect_to prompt_path(@prompt)
        }
      format.js
      end
    end
  end

  private
  def vote_params
      params.require(:vote).permit(:polarity, :votable_id, :votable_type)
  end
end
