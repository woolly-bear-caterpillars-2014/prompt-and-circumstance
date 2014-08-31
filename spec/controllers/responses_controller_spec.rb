require 'rails_helper'

describe ResponsesController do
  let(:prompt){ FactoryGirl.create(:prompt) }
  let(:response){ Response.new(body: "His name is Sleepy!") }
  let(:user) { FactoryGirl.create(:user) }

  context "when logged in" do
    before do
      session[:user_id] = user.id
    end

    it "should create a new Response Object with valid params" do
      expect{
        post :create,
        :prompt_id => prompt.id,
        :response => {
          :body => response.body
        }
      }.to change{ prompt.responses.count }.by(1)
    end

    it "should create a new Response Object with invalid params" do
      expect{
        post :create,
        :prompt_id => prompt.id,
        :response => {
          :body => ""
        }
      }.to change{ prompt.responses.count }.by(0)
    end
  end

  context "when not logged in" do
    it "should redirect to index path" do
      session.clear
      post :create,
      :prompt_id => prompt.id,
      :response => {
        :body => ""
      }
      expect(response).to redirect_to root_path
    end
  end
end
