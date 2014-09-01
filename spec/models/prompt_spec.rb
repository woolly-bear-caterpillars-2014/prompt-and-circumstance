require 'rails_helper'

describe Prompt do
	let(:user){ FactoryGirl.create(:user) }
	let(:prompt){ user.prompts.create(title: "Spice Girls", description: "Who's the best?") }

	it { should belong_to :user }
	it { should have_many :responses }
	it { should have_many :votes }
	it { should validate_presence_of :title }
	it { should validate_presence_of :description }
	it { should validate_presence_of :user_id}
	
	# it "should have an initial score of 0" do
	# 	prompt.score ||= 0
	# end
end
