require 'rails_helper'

describe User do
	let(:user){ FactoryGirl.create(:user) }

	it { should have_many :prompts }
	it { should have_many :responses }
	it { should have_many :votes }
	it { should validate_presence_of :email }
	it { should validate_presence_of :password }
	it { should validate_presence_of :name }


end
