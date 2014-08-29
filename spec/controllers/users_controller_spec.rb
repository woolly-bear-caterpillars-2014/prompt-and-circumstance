require 'rails_helper'

describe UsersController do
  context "create" do
    before do
      post :create, :user => {
        :name => "Bob",
        :email => "bob@bob.com",
        :password => "1234567"
      }
    end

    it "creates a new valid user" do
      expect(User.last.name).to eq("Bob")
    end

    it { should respond_with(:redirect) }
    it { should redirect_to(root_url) }
  end
  context "new user session" do
    before do
      post :create, :user => {
        :name => "Bob",
        :email => "bob@bob.com",
        :password => "1234567"
      }
    end
    it "creates a new session when a user is created" do
      expect(session[:user_id]).to be
    end
  end
  # context "user login session" do
  #   before do
  #     post :login, :user => {
  #       :email => "bob@bob.com",
  #       :password => "1234567"
  #     }
  #   end
  #   it "creates a new session when a user logs in" do
  #     expect(session[:user_id]).to be
  #   end
  #end
end
