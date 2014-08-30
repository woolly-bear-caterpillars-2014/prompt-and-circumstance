require 'rails_helper'
describe SessionsHelper do
  describe "display_session_links" do
    let(:user) { FactoryGirl.create(:user) }

    it "should render logout partial if user is logged in" do
      session[:user_id] = user.id
      expect(helper.display_session_links).to render_template('partials/_logout')
    end

    it "should render login if no current session" do
      session[:user_id] = nil
      expect(helper.display_session_links).to render_template('partials/_login_links')
    end
  end

  describe "current_user" do
    let(:user) { FactoryGirl.create(:user) }

    it "returns the currently logged in user" do
      session[:user_id] = user.id
      expect(helper.current_user).to eq(user)
    end
  end
end
