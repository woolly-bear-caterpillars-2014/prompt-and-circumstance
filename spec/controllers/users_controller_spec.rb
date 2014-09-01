require 'rails_helper'

describe UsersController do

  context "get user signup page" do
    before do
      get :new
    end

    it { should render_template(:new) }

    it "assigns new user to variable" do
      expect(assigns(:user)).to be
    end
  end

  context "create with valid params" do
    params = {:user => {
      :name => "Bob",
      :email => "bob@bob.com",
      :password => "1234567"
    }}

    before do
      session.clear
      post :create, params
    end

    it "creates a new user" do
      expect{
      	post :create,
      	:user => {
      	  :name => "Bob2",
      	  :email => "bob2@bob.com",
      	  :password => "1234567"
      	}
      }.to change{ User.all.count }.by(1)
    end

    it { should redirect_to(root_path) }

    it "creates a new session when a user is created" do
      expect(session[:user_id]).to be
    end
  end

  context "create with invalid params" do
    params = {:user => {
	:name => "",
	:email => "bob@bob.com",
	:password => "1234567"
      }}

    before do
      session.clear
      post :create, params
    end

    it "does not creates a new user" do
      expect{ post :create, params }.not_to change{ User.all.count }
    end

    it { should redirect_to new_user_path }

    it "does not create a new session" do
      expect(session[:user_id]).to be_nil
    end
  end
end
