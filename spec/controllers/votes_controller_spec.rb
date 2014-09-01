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
          expect{
            post :createPromptVote,
              :vote => {
              :polarity => 3,
              :votable_id => prompt.id
            }
          }.not_to change{ prompt.votes.count }
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

        session[:user_id] = nil
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
          expect{
            post :createResponseVote,
              :id => prompt.id,
              :vote => {
              :polarity => 1,
              :votable_id => response.id
            }
          }.to change{ response.votes.count }.by(1)
        end
      end

      context 'with invalid params' do
        it 'does not create a new vote' do
          current_session
          expect{
            post :createResponseVote,
              :id => prompt.id,
              :vote => {
              :polarity => 3,
              :votable_id => response.id
            }
          }.not_to change{ response.votes.count }
        end
      end

      context "with a duplicate vote" do
        it "does not create a new vote" do
          current_session

          # Vote once
          post :createResponseVote,
            :id => prompt.id,
            :vote => {
            :polarity => 1,
            :votable_id => response.id
          }
          # Vote again
          expect{
            post :createResponseVote,
              :id => prompt.id,
              :vote => {
              :polarity => 1,
              :votable_id => response.id
            }
          }.not_to change{ response.votes.count }
        end
      end
    end

    context "when not logged in" do
      it 'does not change vote count' do

        session[:user_id] = nil
        expect{
          post :createResponseVote,
            :id => prompt.id,
            :vote => {
            :polarity => 1,
            :votable_id => response.id
          }
        }.not_to change{ response.votes.count }
      end
    end
  end

  context 'votes on response' do
    it 'creates a new votes on specified response with the correct id' do
      user 
      prompt
      response
      current_session
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

def current_session
  session[:user_id] = user.id
end

def create_prompt_vote
  post :createPromptVote,
              :vote => {
              :polarity => 1,
              :votable_id => prompt.id
            }
end

