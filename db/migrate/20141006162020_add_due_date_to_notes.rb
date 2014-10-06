class AddDueDateToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :due, :date
  end
end
