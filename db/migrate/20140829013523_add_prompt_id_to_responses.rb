class AddPromptIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :prompt_id, :integer
  end
end
