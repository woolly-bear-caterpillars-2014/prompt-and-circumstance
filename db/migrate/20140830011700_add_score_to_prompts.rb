class AddScoreToPrompts < ActiveRecord::Migration
  def change
    add_column :prompts, :score, :integer
  end
end
