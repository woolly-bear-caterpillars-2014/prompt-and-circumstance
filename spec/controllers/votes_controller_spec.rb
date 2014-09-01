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
    context "when logged in" do
      context 'with valid params' do
        it 'creates new vote on specified prompt with supplied session id' do

          session[:user_id] = user.id
          expect{
            post :createPromptVote,
              :vote => {
              :polarity => 1,
              :votable_id => prompt.id
            }
          }.to change{ prompt.votes.count }.by(1)
        end
      end

      context 'with invalid params' do
        it 'does not create a new vote' do
          session[:user_id] = user.id
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
          session[:user_id] = user.id

          # Vote once
          post :createPromptVote,
            :vote => {
            :polarity => 1,
            :votable_id => prompt.id
          }
          # Vote again
          expect{
            post :createPromptVote,
              :vote => {
              :polarity => 1,
              :votable_id => prompt.id
            }
          }.not_to change{ prompt.votes.count }
        end
      end
    end

    context "when not logged in" do
      it 'does not change vote count' do

        session[:user_id] = nil
        expect{
          post :createPromptVote,
            :vote => {
            :polarity => 1,
            :votable_id => prompt.id
          }
        }.not_to change{ prompt.votes.count }
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

          session[:user_id] = user.id
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
          session[:user_id] = user.id
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
          session[:user_id] = user.id

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


