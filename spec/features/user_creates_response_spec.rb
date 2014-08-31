require 'rails_helper'

feature 'User creates a response' do
  let(:user) { FactoryGirl.create(:user) }

  let(:prompt) { Prompt.create(
    title: "What's your name?",
    description: "Is it yeff?",
    user_id: user.id
  ) }

  scenario "with valid input" do
    test_signup

    visit prompt_path(prompt)

    fill_in 'response_body', with: "My name is yeff"
    click_button 'New Response'

    expect(page).to have_content "My name is yeff"
  end

  scenario "with invalid input" do
    test_signup

    visit prompt_path(prompt)

    fill_in 'response_body', with: ""
    click_button 'New Response'

    expect(page).not_to have_content "My name is yeff"
  end
end

def test_signup
  visit "/prompts"
  click_link "Signup"

  fill_in "Name", with: "Teste"
  fill_in "Email", with: "teste@teste.teste"
  fill_in "Password", with: "testeteste"
  click_button "Create Account"
end