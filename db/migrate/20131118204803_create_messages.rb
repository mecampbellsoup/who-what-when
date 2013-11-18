class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to
      t.string :from
      t.string :body
      t.datetime :send_at
      t.receiver_id :references

      t.timestamps
    end
  end
end
