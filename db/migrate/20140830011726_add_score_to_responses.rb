class AddScoreToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :score, :integer
  end
end
