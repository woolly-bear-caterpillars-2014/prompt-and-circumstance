require 'rails_helper.rb'

feature "User votes on prompt: " do

  let(:user) { FactoryGirl.create(:user) }
  let(:prompt) { user.prompts.create(
    title: "What's your name?",
    description: "Is it yeff?"
  ) }
  scenario 'logged in user clicks upvote' do

    prompt
    user

    test_signup
    user_clicks_through_to_show_prompt
    expect(page.first('h4.score')).to have_content('0')
    first('button.up').click

    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page.first('h4.score')).to have_content('1')

  end

  scenario 'logged in user clicks downvote' do

    prompt
    user

    test_signup
    user_clicks_through_to_show_prompt
    expect(page.first('h4.score')).to have_content('0')
    first('button.down').click

    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page.first('h4.score')).to have_content('-1')

  end

  scenario 'un-logged in user clicks upvote' do
    prompt

    user_clicks_through_to_show_prompt
    expect(page.first('h4.score')).to have_content('0')
    first('button.up').click

    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page.first('h4.score')).to have_content('0')
    expect(page).to have_content('Must be logged in to vote! What are you trying to do you dirty vote scammer??')
  end

  scenario 'un-logged in user clicks downvote' do
    prompt

    user_clicks_through_to_show_prompt
    expect(page.first('h4.score')).to have_content('0')
    first('button.down').click

    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page.first('h4.score')).to have_content('0')
    expect(page).to have_content('Must be logged in to vote! What are you trying to do you dirty vote scammer??')
  end


  scenario 'logged in user clicks upvote attempting mutiple votes, invalidates subsequent' do

    prompt
    user

    test_signup
    user_clicks_through_to_show_prompt
    expect(page.first('h4.score')).to have_content('0')
    first('button.up').click

    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page.first('h4.score')).to have_content('1')

    first('button.up').click
    expect(current_url).to eq("http://www.example.com/prompts/#{Prompt.last.id}")
    expect(page.first('h4.score')).to have_content('1')
    expect(page).to have_content('What are you trying to do you dirty vote scammer??')

  end

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

  expect(page).to have_content("#{prompt.title}")

  click_link "#{prompt.title}"

  expect(current_url).to eq("http://www.example.com/prompts/#{prompt.id}")

end










