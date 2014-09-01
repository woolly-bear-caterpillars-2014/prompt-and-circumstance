require 'rails_helper'

describe VotesController do

  let(:user) { FactoryGirl.create(:user) }
  let(:prompt) { user.prompts.create(
                  title: "What's your name?",
                  description: "Is it yeff?"
              ) }
  let(:response) { prompt.responses.create(
                  body: "Sleepy? He's like the mexican wolverine"
                ) }

  context 'votes on prompt' do
    context 'when logged in' do
      context 'with valid params' do
        it 'creates new vote on specified prompt with supplied session id' do
          current_session
          expect{ create_prompt_vote }.to change{ prompt.votes.count }.by(1)
        end
      end

      context 'with invalid params' do
        it 'does not create a new vote' do
          current_session
          expect{ create_multiple_prompt_votes }.not_to change{ prompt.votes.count }
        end
      end

      context "with a duplicate vote" do
        it "does not create a new vote" do
          current_session
          # Vote once
          create_prompt_vote
          # Vote again
          expect{ create_prompt_vote }.not_to change{ prompt.votes.count }
        end
      end
    end

    context "when not logged in" do
      it 'does not change vote count' do

        no_session
        expect{ create_prompt_vote }.not_to change{ prompt.votes.count }
      end
    end
  end

  context 'votes on responses' do

    let(:prompt) { FactoryGirl.create(:prompt) }
    let(:user) { FactoryGirl.create(:user) }
    let(:response) { Response.create(body: "So cool", user_id: user.id, prompt_id: prompt.id) }

    context "when logged in" do
      context 'with valid params' do
        it 'creates new vote on specified response with supplied session id' do

          current_session
          expect{ create_response_vote }.to change{ response.votes.count }.by(1)
        end
      end

      context 'with invalid params' do
        it 'does not create a new vote' do
          current_session
          expect{ create_multiple_response_votes }.not_to change{ response.votes.count }
        end
      end

      context "with a duplicate vote" do
        it "does not create a new vote" do
          current_session
          # Vote once
          create_response_vote
          # Vote again
          expect{ create_response_vote }.not_to change{ response.votes.count }
        end
      end
    end

    context "when not logged in" do
      it 'does not change vote count' do

        no_session
        expect{ create_response_vote }.not_to change{ response.votes.count }
      end
    end
  end
end

##METHODS FOR READABILITY

def current_session
  session[:user_id] = user.id
end

def no_session
  session[:user_id] = nil
end

def create_prompt_vote
  post :createPromptVote,
              :vote => {
              :polarity => 1,
              :votable_id => prompt.id
            }
end

def create_multiple_prompt_votes
  post :createPromptVote,
              :vote => {
              :polarity => 3,
              :votable_id => prompt.id
            }
end

def create_response_vote
  post :createResponseVote,
              :id => prompt.id,
              :vote => {
              :polarity => 1,
              :votable_id => response.id
            }
end

def create_multiple_response_votes
  post :createResponseVote,
              :id => prompt.id,
              :vote => {
              :polarity => 3,
              :votable_id => response.id
            }
end

