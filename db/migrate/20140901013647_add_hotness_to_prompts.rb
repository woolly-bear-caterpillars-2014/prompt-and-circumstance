class AddHotnessToPrompts < ActiveRecord::Migration
  def up
    add_column :prompts, :hotness, :integer
  end

  def down
    remove_column :prompts, :hotness
  end
end
