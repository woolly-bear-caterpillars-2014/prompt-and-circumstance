require 'rails_helper.rb'

feature "user creates prompt" do
  scenario 'with valid inputs' do

    user_clicks_through_to_new_form_fills_title

    fill_in "Description", with: "Valid description, etc etc pontificate"
    click_button "Create Prompt"

    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page).to have_content("Valid Title")
    expect(page).to have_content("Valid description, etc etc pontificate")
  end

  scenario 'with invalid inputs' do

    user_clicks_through_to_new_form_fills_title

    # user doesn't fill in description... why so STUPID????

    click_button "Create Prompt"
    expect(current_url).to eq("http://www.example.com/prompts/new")
    expect(page).to have_content("Invalid Prompt Submission, Please Try Again!")

    expect(page).to have_content("Valid Title")
    # because they input 1 field, can the info persist w/out save?

  end

end


def user_clicks_through_to_new_form_fills_title
  visit "/prompts"
  click_link "Create Prompt"

  expect(page).to have_content("New Prompt")
  expect(current_url).to eq("http://www.example.com/prompts/new")

  fill_in "Title", with: "Valid Title"
end










