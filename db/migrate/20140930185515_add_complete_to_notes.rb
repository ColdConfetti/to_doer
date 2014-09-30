class AddCompleteToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :complete, :boolean
  end
end
