class AddHotnessToPrompts < ActiveRecord::Migration
  def up
    add_column :prompts, :hotness, :float, :default => 0.0
    change_column :prompts, :score, :integer, :default => 0
  end

  def down
    remove_column :prompts, :hotness
  end
end
