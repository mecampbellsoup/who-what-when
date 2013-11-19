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

  def send_time
    write_attribute :send_at, Time.now
  end

  def self.create_from_text_message(params)
   @message = Message.new
   @message.receiver = params["From"]
   @message.body = params["Body"]
   @message.send_time
   @message.save
   @message
  end

end
