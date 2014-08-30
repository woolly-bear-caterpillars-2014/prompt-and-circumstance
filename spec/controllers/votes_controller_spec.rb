require 'rails_helper'

describe VotesController do

  let(:prompt) { FactoryGirl.create(:prompt) }


  context 'votes on prompt' do
    it 'creates new vote on specified prompt' do
      expect{
        post :createPromptVote,
          :vote => {
          :polarity => 1,
        }
      }.to change{ Vote.all.count }.by(1)
    end
  end

end
