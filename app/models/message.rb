class Message < ActiveRecord::Base
  belongs_to :receiver

  extend Textable

  def receiver=(phone_number)
    self.receiver.build_from_message(phone_number)
  end

  def send_at=(date)
    if date.is_a?(Time)
      write_attribute :send_at, date
    else
      date = Chronic.parse(date) || Time.now
      write_attribute :send_at, date
    end
  end

end
