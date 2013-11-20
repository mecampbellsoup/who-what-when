require 'spec_helper'

describe Message do
  include MessagesHelper

  context "creating a message from the website" do 
    
    let(:receiver) { Receiver.new(:phone => "740-319-0208") }
    let(:message) { receiver.messages.build(:body => "sdfsf", :send_at => "in 5 seconds") }

    before(:each) do
      receiver.save
      message.save
    end

    it "creates a message" do 
      expect(message).to be_a Message
    end

    it "creates or assigns a receiver" do 
      expect(message.receiver).to be_a(Receiver)
    end

    it "assigns the message body to the params form" do 
      expect(message.body).to eq "sdfsf"
    end
  end

  context "multiple messages to the same receiver" do 
    it "does not duplicate a receiver instance" do 
      5.times do 
        message = Message.create(:receiver => Receiver.find_or_create_by(:phone => format_phone_number("740-319-0208")))
      end
      expect(Message.count).to eq 5
      expect(Receiver.count).to eq 1
    end
  end


  context "creating a message from a text message" do 

    let(:receiver) { Receiver.new(:phone => "740-319-0208") }

    before :each do 
      receiver.save
      @params = {"Body"=>"Body of the message in 30 seconds", "AccountSid"=>"AC", "MessageSid"=>"SM37e06f9540c0943477d6a5ce974cc2fd", "ToZip"=>"11238", "ToCity"=>"BROOKLYN", "FromState"=>"CA", "ToState"=>"NY", "SmsSid"=>"SM37e06f9540c0943477d6a5ce974cc2fd", "To"=>"+13476948027", "ToCountry"=>"US", "FromCountry"=>"US", "SmsMessageSid"=>"SM37e06f9540c0943477d6a5ce974cc2fd", "ApiVersion"=>"2010-04-01", "FromCity"=>"ALHAMBRA", "SmsStatus"=>"received", "NumMedia"=>"0", "From"=>"+16262444636", "FromZip"=>"91006"}  
      @message = receiver.create_from_sms(@params)
    end

    it "creates a message" do 
      expect(@message).to be_a Message
    end

    it "creates or assigns a receiver" do 
      expect(@message.receiver).to be_a Receiver
    end

    it "assigns a text message to the time in the body" do 
      expect(@message.body).to eq "Body of the message"
    end

    it "correctly parses the time from the message" do
      expect(@message.send_at).to be_a(Time)
    end

    it "assign's a receiver's phone number to the params entry" do 
      expect(@message.receiver.phone).to eq @params["From"]
    end

  end

end
