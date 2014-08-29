require 'rails_helper'

feature 'User creates a response' do
  let(:prompt) { FactoryGirl.build_stubbed(:prompt) }

  scenario 'user sees the response form' do
    visit prompt_path

    fill_in 'Response Body', with: "My name is yeff"
    click_button 'Create Response'

    expect(page).to have_content "My name is yeff"
  end
end
