require 'rails_helper'

describe PromptsController do
  context "#index" do
    it "assigns all prompts to a variable" do
      get :index
      expect(assigns(:prompts)).not_to be_nil
    end
  end
end
