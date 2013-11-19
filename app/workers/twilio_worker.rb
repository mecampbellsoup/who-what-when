class TwilioWorker
  
  include Sidekiq::Worker

  def perform(message_id)
    message = Message.find(message_id)
    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
 
    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    puts @twilio_client.inspect #lots of puts statements to sidekiq 

    @twilio_client.account.sms.messages.create(
      :from => ENV['TWILIO_PHONE_NUMBER'],
      :to => message.receiver.phone,
      :body => message.body
    )
  end
end