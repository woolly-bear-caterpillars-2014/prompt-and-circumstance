require 'rails_helper.rb'


feature 'User votes on a response:' do 

	let(:user) { FactoryGirl.create(:user) }
	let(:prompt) { user.prompts.create(
    title: "What's your name?",
    description: "Is it yeff?"
  ) }
	let(:response) { prompt.responses.create(
		body: "Sleepy? He's like the mexican wolverine"
		)}

	 scenario 'logged in user clicks upvote' do
	 	
	 	prompt
	 	user
	 	response

	 	test_signup
	 	user_clicks_through_to_show_prompt

    expect(page.first('h4.score')).to have_content('0')
	 	first('button.up').click

	 	expect(current_url).to eq("http://www.example.com/prompts/#{prompt.id}")
		expect(page.first('h4.score')).to have_content('1')
	 end


end

def test_signup
	visit "/prompts"
	click_link "Signup"

	fill_in "Name", with: "Teste"
	fill_in "Email", with: "teste@teste.teste"
	fill_in "Password", with: "testteste"
	click_button "Create Account"
end

def user_clicks_through_to_show_prompt
	visit "/prompts"
	click_link "#{prompt.title}"

	expect(page).to have_content("#{prompt.title}")
	expect(current_url).to eq("http://www.example.com/prompts/#{prompt.id}")
end

