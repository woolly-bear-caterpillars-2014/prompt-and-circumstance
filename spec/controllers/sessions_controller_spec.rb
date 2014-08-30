require 'rails_helper'

describe SessionsController do
  context "GET login" do
    it "should show the login page" do
      get :new, :action => :login
      expect(response).to render_template :new
    end
  end

  context "POST login" do
    context "with valid params" do
      let(:user){ FactoryGirl.create(:user) }

      before do
        post :create, :action => :login, email: user.email, password: user.password
      end

      it "creates a new session for user" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to index" do
        expect(response).to redirect_to('/')
      end
    end

    it "re-renders login page if invalid input" do
      post :create, :action => :login, email: "", password: ""
      expect(response).to render_template(:new)
    end
  end

  context "DELETE logout" do
    let(:user){ FactoryGirl.create(:user) }

    it "clears session" do
      delete :destroy, :action => :logout
      expect(session[:user_id]).to be_nil
    end
  end
end
