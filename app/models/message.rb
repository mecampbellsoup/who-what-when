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
   @message.body = parse_body_from_text_sentence(params["Body"])
   if send_time != nil 
     @message.send_time
   else
     arse_time_from_text_sentence(params["Body"])
   end
   @message.save
   @message
  end

  def parse_time_from_text_sentence(sentence)
    Chronic.parse(sentence.split(":").last)
  end

  def parse_body_from_text_sentence(sentence)
    body = sentence.split(":").first
  end


end
