class Message < ActiveRecord::Base
  belongs_to :receiver

  def send_at=(date)
    if !date.is_a?(Time)
      date = Chronic.parse(date) || Time.now
    end
    write_attribute :send_at, date
  end

end
