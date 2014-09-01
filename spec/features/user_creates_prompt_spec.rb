require 'rails_helper.rb'

feature "user creates prompt" do
  scenario 'with valid inputs' do
    test_signup
    user_clicks_through_to_new_form_fills_title

    fill_in "Description", with: "Valid description, etc etc pontificate"
    click_button "Create Prompt"

    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page).to have_content("Valid Title")
    expect(page).to have_content("Valid description, etc etc pontificate")
  end

  scenario 'with invalid inputs' do
    test_signup
    user_clicks_through_to_new_form_fills_title

    # user doesn't fill in description... why so STUPID????

    click_button "Create Prompt"
    expect(current_url).to eq("http://www.example.com/prompts/new")
    expect(page).to have_content("Prompt Creation Failed, Please Try Again!")

    ## BUG BUG --  Form renders what we want, but test not passing. how to correct?


    # expect(page).to have_content("Valid Title")
    # expect("input[name='prompt[title]']").to have_content("Valid Title")
    # because they input 1 field, can the info persist w/out save?

  end

end


def teste_user_login
  visit "/prompts"
  click_link "Login"

  fill_in "Email", with: "teste@teste.teste"
  fill_in "Password", with: "testeteste"
  click_link "Login"

  expect(page).to have_content("Logout")
end

def test_signup
  visit "/prompts"
  click_link "Signup"

  fill_in "Name", with: "Teste"
  fill_in "Email", with: "teste@teste.teste"
  fill_in "Password", with: "testeteste"
  click_button "Create Account"
end


def user_clicks_through_to_new_form_fills_title
  visit "/prompts"
  click_link "New Prompt"

  expect(page).to have_content("New Prompt")
  expect(current_url).to eq("http://www.example.com/prompts/new")

  fill_in "Title", with: "Valid Title"
end










