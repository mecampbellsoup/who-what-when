class Message < ActiveRecord::Base
  belongs_to :receiver
  validates :body, :presence => true
  validates :send_at, :presence => true

  def send_at=(date)
    if date.is_a?(String)
      date = Chronic.parse(date)
    end
    write_attribute :send_at, date
  end

  def queue_message_to_be_sent(time, message_id)
      TwilioWorker.perform_at(time, message_id)
  end

end
