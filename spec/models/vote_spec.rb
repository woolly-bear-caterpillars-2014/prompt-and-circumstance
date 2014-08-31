require 'rails_helper'

describe Vote do
  let(:vote) {Vote.create(
      user_id: 1,
      votable_id: 1,
      votable_type: 'Prompt',
      polarity: 1)
  }

  it 'should not allow duplicate votes to be cast' do
    vote.save
    puts vote
    dup = Vote.new(user_id: vote.user,
                  votable_id: vote.votable_id,
                  votable_type: vote.votable_type,
                  polarity: vote.polarity)

    dup.check_against_duplicates
    expect(dup.save).to eq(false)
  end

end
