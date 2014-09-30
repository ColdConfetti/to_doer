class AddContentColumnToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :user_id, :integer
    add_column :notes, :content, :string
  end
end
