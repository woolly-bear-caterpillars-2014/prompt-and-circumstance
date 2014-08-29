require 'rails_helper'

feature 'User creates a response' do
  let(:prompt) { Prompt.create(
    title: "What's your name?",
    description: "Is it yeff?"
  ) }

  scenario 'user sees the response form' do
    visit prompt_path(prompt)

    fill_in 'Response Body', with: "My name is yeff"
    click_button 'Create Response'

    expect(page).to have_content "My name is yeff"
  end
end
