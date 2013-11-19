class Message < ActiveRecord::Base
  belongs_to :receiver
  #validates_presence_of :receiver

  def receiver=(phone_number)
    @receiver_id = Receiver.find_or_create_by(:phone => phone_number).id
    write_attribute :receiver_id, @receiver_id
  end

  def send_at=(date)
    date = Chronic.parse(date) || Time.now
    write_attribute :send_at, date
  end

  # def send!
    # TODO: this method should check the api to verify successful send; then return true or false (in event of failure to send)
  # end
end
