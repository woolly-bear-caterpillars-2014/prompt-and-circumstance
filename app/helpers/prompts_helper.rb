module PromptsHelper
  include ActionView::Helpers::DateHelper

  def prompt_user_and_time(prompt)
    "#{prompt.user.name} #{time_ago_in_words(prompt.created_at)} ago"
  end

  # for code org, put this in ResponseHelper
  def response_vote_form_params
    { :action => "createResponseVote", 
      :controller => "votes", 
      id: @prompt.id, 
      vote: { votable_id: response.id, polarity: -1, votable_type: response.class }
    }
  end
end
