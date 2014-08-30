class VotesController < ApplicationController


  # EDDIE:
  #we should use separate routes + controller actions for votes on Prompts and Responses - we'll handle prompts- take the responses

  ### Prompt Vote Create

  def createPromptVote
    @prompt = Prompt.find(params[:vote][:votable_id])
    @vote = @prompt.votes.create(vote_params)
    @prompt.update_score(@vote)
    redirect_to prompt_path(@prompt)
  end


  ### and for Responses
  def createResponseVote
  end

  private
  def vote_params
      params.require(:vote).permit(:polarity, :votable_id, :votable_type)
  end



end
