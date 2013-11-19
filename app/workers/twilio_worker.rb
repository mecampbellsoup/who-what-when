class TwilioWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(message_id)
    # later will add 'send_at' param for the boomerang effect
    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
 
    message = Message.find(message_id)
    twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
 
    twilio_client.account.sms.messages.create(
      :from => ENV['TWILIO_PHONE_NUMBER'],
      :to => message.receiver.phone,
      :body => message.body
    )
  end
end