class RemoveFromFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :from, :string
  end
end
