class AddReceiverIdToMessages < ActiveRecord::Migration
  def change
    add_reference :messages, :receiver, index: true
  end
end
