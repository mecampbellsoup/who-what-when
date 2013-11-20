class Message < ActiveRecord::Base
  belongs_to :receiver

  def send_at=(date)
    if date.is_a?(Time)
      write_attribute :send_at, date
    else
      date = Chronic.parse(date) || Time.now
      write_attribute :send_at, date
    end
  end

end
