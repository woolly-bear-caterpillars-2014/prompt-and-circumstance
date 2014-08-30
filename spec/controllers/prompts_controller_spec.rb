require 'rails_helper'

describe PromptsController do
  context "#index" do
    it "assigns all prompts to a variable" do
      get :index
      expect(assigns(:prompts)).not_to be_nil
    end
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:prompt) { FactoryGirl.build(:prompt) }

  context "GET new" do
    context "when logged in" do
      it "shows the new prompt page" do
        session[:user_id] = user.id
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "when not logged in" do
      it "redirects to index" do
        get :new
        expect(response).to redirect_to('/')
      end
    end
  end

  context "POST create" do

    context "when logged in" do

     context "with valid params" do
      it "creates a new prompt for currrent_user" do
        expect{
          post :create,
          prompt: {
            title: prompt.title,
            description: prompt.description
          }
        }.to change{ Prompt.all.count }.by(1)
      end

      it "redirects to new prompt page" do
        post :create, prompt: {
          title: prompt.title,
          description: prompt.description
        }
        expect(response).to redirect_to(assigns(:prompt))
        end
      end

      context "with invalid params" do
        it "re-renders the new prompt page" do
          post :create, prompt: {
            title: "",
            description: ""
          }
          expect(response).to render_template(:new)
        end
      end
    end
  end

  context "GET show" do
    let(:prompt) { FactoryGirl.create(:prompt) }

    before do
      get :show, :id => prompt.id
    end

    it "assigns the prompt to a variable" do
      expect(assigns(:prompt)).to be
    end

    it 'creates an empty response variable' do
      expect(assigns(:response)).to be
    end
  end
end
