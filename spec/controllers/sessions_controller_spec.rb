require 'rails_helper'

describe SessionsController do
  context "GET login" do
    it "should show the login page" do
      get :new, :action => :login
      expect(response).to render_template :new
    end
  end

  context "POST login" do
    let(:user){ FactoryGirl.create(:user) }

    it "should create a new session" do
      post :create, :action => :login, email: user.email, password: user.password
      expect(session[:user_id]).to eq(user.id)
    end
  end

  context "DELETE logout" do
    let(:user){ FactoryGirl.create(:user) }

    it "should clear session" do
      delete :destroy, :action => :logout
      expect(session[:user_id]).to be_nil
    end
  end
end
