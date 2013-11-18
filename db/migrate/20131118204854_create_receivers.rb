class CreateReceivers < ActiveRecord::Migration
  def change
    create_table :receivers do |t|
      t.string :phone

      t.timestamps
    end
  end
end
