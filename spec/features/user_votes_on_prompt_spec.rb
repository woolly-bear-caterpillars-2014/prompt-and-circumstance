require 'rails_helper.rb'

feature "User votes on prompt: " do

  let(:user) { FactoryGirl.create(:user) }
  let(:prompt) { FactoryGirl.create(:prompt) }



  scenario 'logged in user clicks upvote' do

    prompt
    user

    test_signup
    user_clicks_through_to_show_prompt
    expect(page).to have_content('Score: 0')
    click_button("up")

    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page).to have_content('Score: 1')

  end

  scenario 'logged in user clicks downvote'

  scenario 'un-logged in user clicks upvote'
  scenario 'un-logged in user clicks downvote'

  scenario 'logged in user clicks upvote attempting mutiple votes, invalidates subsequent'
  scenario 'logged in user clicks downvote attempting mutiple votes, invalidates subsequent'


    # test_signup
    # user_clicks_through_to_new_form_fills_title

    # # user doesn't fill in description... why so STUPID????

    # click_button "Create Prompt"
    # expect(current_url).to eq("http://www.example.com/prompts/new")
    # expect(page).to have_content("Prompt Creation Failed, Please Try Again!")

    ## BUG BUG --  Form renders what we want, but test not passing. how to correct?


    # expect(page).to have_content("Valid Title")
    # expect("input[name='prompt[title]']").to have_content("Valid Title")
    # because they input 1 field, can the info persist w/out save?



end

def test_signup
  visit "/prompts"
  click_link "Signup"

  fill_in "Name", with: "Teste"
  fill_in "Email", with: "teste@teste.teste"
  fill_in "Password", with: "testeteste"
  click_button "Create Account"
end

def user_clicks_through_to_show_prompt
  visit "/prompts"
  click_link "#{prompt.title}"

  expect(page).to have_content("#{prompt.title}")
  expect(current_url).to eq("http://www.example.com/prompts/#{prompt.id}")

end










