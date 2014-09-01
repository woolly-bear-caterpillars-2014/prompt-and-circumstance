require 'rails_helper'

describe Prompt do
	let(:user){ FactoryGirl.create(:user) }
	let(:prompt){ user.prompts.create(title: "Spice Girls", description: "Who's the best?") }
	let(:vote){ prompt.votes.create(:votable_id => prompt.id, :votable_type => "Prompt", :polarity => 1 ) }

	it { should belong_to :user }
	it { should have_many :responses }
	it { should have_many :votes }
	it { should validate_presence_of :title }
	it { should validate_presence_of :description }
	it { should validate_presence_of :user_id}
	
	it "should have an initial score of 0" do
		expect(prompt.score).to eq(0)
	end

	it "should update score when voted on" do 
		prompt.update_score(vote)
		expect( prompt.score ).to eq(1)
	end

	it "should have a description length less than 100 characters" do
		expect(prompt.description.length).to_not eq(100)
	end

	it "should return description if description length is less than 100 characters" do
		expect(prompt.description).to eq "Who's the best?"
	end

	it "should return description with '...' after the 100th character if description length is more than 100 characters" do
		
		prompt1 = Prompt.create(title: "Spice Girls", description: "Awesome. I am going to be typing about alot of useless things to get to one hundred characters! Yay! What else should I talk about?")

		expect(prompt1.short_description).to eq "Awesome. I am going to be typing about alot of useless things to get to one hundred characters! Yay! ..."
	end
	
end
