require 'rails_helper'

describe VotesController do

  let(:user) { FactoryGirl.create(:user) }
  let(:prompt) { user.prompts.create(title: "What's your name?",
    description: "Is it yeff?"
  ) }
  let(:response) { prompt.responses.create(
  body: "Sleepy? He's like the mexican wolverine"
  )}

  context 'votes on prompt' do
    it 'creates new vote on specified prompt with supplied session id' do
      user
      prompt
      session[:user_id] = user.id
      expect{
        post :createPromptVote,
          :vote => {
          :polarity => 1,
          :votable_id => prompt.id
        }
      }.to change{ Vote.all.count }.by(1)
    end

  end

  context 'votes on response' do
    it 'creates a new votes on specified response with the correct id' do
      user 
      prompt
      response
      session[:user_id] = user.id
      expect{
        post :createResponseVote, 
          :vote => { 
          :polarity => 1, 
          :votable_id => response.id
        }
      }.to change{ Vote.all.count }.by(1)

    end
  end
end


