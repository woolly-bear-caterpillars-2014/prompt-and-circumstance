require 'rails_helper'

describe Response do
	let(:user){ FactoryGirl.create(:user) }
	let(:prompt){user.prompts.create(:title => "Beagles", :description => "How awesome are beagles?" )}
	let(:response){ prompt.responses.create(:body => "Really awesome!", :user_id => user.id, :prompt_id => prompt.id)}
	let(:vote){ response.votes.create(:votable_id => response.id, :votable_type => "Response", :polarity => 1 )}

	it { should belong_to :prompt }
	it { should belong_to :user }
	it { should have_many :votes }
	it { should validate_presence_of :body}
	it { should validate_presence_of :user_id}
	it { should validate_presence_of :prompt_id}
	
	it "should have an initial score of 0" do
		expect(response.score).to eq 0
	end

	it "should update score when voted on" do
		response.upvote(vote)
		expect(response.score).to eq 1
	end
end
