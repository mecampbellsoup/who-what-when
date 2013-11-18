class Message < ActiveRecord::Base
  belongs_to :receiver
  #validates_presence_of :receiver

  def receiver=(phone_number)
    @receiver_id = Receiver.find_or_create_by(:phone => phone_number).id
    write_attribute :receiver_id, @receiver_id
  end

  def send!
    # later will add 'send_at' param for the boomerang effect
    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    @twilio_client.account.sms.messages.create(
      :from => ENV['TWILIO_PHONE_NUMBER'],
      :to => receiver.phone,
      :body => body
    )
    # TODO: this method should check the api to verify successful send; then return true or false (in event of failure to send)
  end
end
