class CreateSmsTimeValidators < ActiveRecord::Migration
  def change
    create_table :sms_time_validators do |t|

      t.timestamps
    end
  end
end
