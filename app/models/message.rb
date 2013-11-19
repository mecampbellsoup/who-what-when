class Message < ActiveRecord::Base
  belongs_to :receiver

  def receiver=(phone_number)
    @receiver_id = Receiver.find_or_create_by(:phone => phone_number).id
    write_attribute :receiver_id, @receiver_id
  end

  def send_at=(date)
    date = Chronic.parse(date) || Time.now
    write_attribute :send_at, date
  end

end
