require 'rails_helper'

feature 'user views a prompt' do
  let(:user) { FactoryGirl.create(:user) }
  let(:prompt) { user.prompts.create(
    title: "What's your name?",
    description: "Is it yeff?"
  ) }

  scenario 'valid prompt valid path' do
    visit prompt_path(prompt)

    expect(page).to have_content "What's your name?"
    expect(page).to have_content "Is it yeff?"

  end
end
