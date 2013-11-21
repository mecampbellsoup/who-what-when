class Message < ActiveRecord::Base
  belongs_to :receiver
  validates :body, :presence => true

  def send_at=(date)
      validate(date)
      write_attribute :send_at, date
  end

  def validate(date)
    if !date.is_a?(Time)
      if chronic_can_parse?(date)
        parse(date)
      else
        begin
        raise
        rescue
        create_error_message 
        end
      end
    end
  end

  def chronic_can_parse?(date)
    if Chronic.parse(date)
      true
    else
      false
    end
  end

  def parse(date)
    Chronic.parse(date)
  end

  def errors?
    self.errors[:send_at].any?
  end
     
  def create_error_message
    self.body = "Hello! You didn't send us a time. Please send again."
    send_error_message 
  end  

  def send_error_message
    self.save
    queue_message_to_be_sent(Time.now, self.id)
  end

  def queue_message_to_be_sent(time, message_id)
      TwilioWorker.perform_at(time, message_id)
  end

end
