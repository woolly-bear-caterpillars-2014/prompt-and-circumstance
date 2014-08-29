require 'rails_helper.rb'

feature "user creates prompt" do
  scenario 'with valid inputs' do

    visit "/prompts"
    click_link "Create Prompt"

    expect(page).to have_content("New Prompt")
    expect(current_url).to eq("http://www.example.com/prompts/new")

    fill_in "Title", with: "Valid Title"
    fill_in "Description", with: "Valid description, etc etc pontificate"
    click_button "Create Prompt"

    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page).to have_content("Valid Title")
    expect(page).to have_content("Valid description, etc etc pontificate")
  end

  # scenario 'with shitty form' do
    # visit "/questions"

    # fill_in "Title", with: "very stupid cookie question"
    # click_button "Create"

    # expect(page).not_to have_content("very stupid cookie question")
    # expect(page).to have_content("Question failed to save.")
    # expect(current_url).to eq("http://www.example.com/questions")
  # end

end
