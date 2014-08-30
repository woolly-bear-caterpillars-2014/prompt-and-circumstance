require 'rails_helper'

describe VotesController do

  let(:prompt) { FactoryGirl.create(:prompt) }


  context 'votes on prompt' do
    it 'creates new vote on specified prompt' do
      prompt
      expect{
        post :createPromptVote,
          :vote => {
          :polarity => 1,
          :votable_id => prompt.id
        }
      }.to change{ Vote.all.count }.by(1)
    end
  end

end
