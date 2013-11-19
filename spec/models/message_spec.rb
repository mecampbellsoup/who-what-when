require 'spec_helper'

describe Message do
  context "creating a message from the website" do 
    before :each do 
      @params = {"receiver"=>"+13432", "body"=>"sdfsf", "send_at"=>"dfdf"}
      @message = Message.create(@params)
    end

    it "creates a message" do 
      expect(@message).to be_a Message
    end

    it "creates or assigns a receiver" do 
      expect(@message.receiver.phone).to eq @params["receiver"]
    end

    it "assigns the message body to the params form" do 
      expect(@message.body).to eq @params["body"]
    end

    context "multiple messages to the same receiver" do 
      it "does not duplicate a receiver instance" do 
        5.times do 
          @message = Message.create(@params)
        end

        expect(Message.count).to eq 6
        expect(Receiver.count).to eq 1
      end
    end
  end


  context "creating a message from a text message" do 
    before :each do 
      @params = {"AccountSid"=>"AC", "MessageSid"=>"SM37e06f9540c0943477d6a5ce974cc2fd", "Body"=>"Body of the message", "ToZip"=>"11238", "ToCity"=>"BROOKLYN", "FromState"=>"CA", "ToState"=>"NY", "SmsSid"=>"SM37e06f9540c0943477d6a5ce974cc2fd", "To"=>"+13476948027", "ToCountry"=>"US", "FromCountry"=>"US", "SmsMessageSid"=>"SM37e06f9540c0943477d6a5ce974cc2fd", "ApiVersion"=>"2010-04-01", "FromCity"=>"ALHAMBRA", "SmsStatus"=>"received", "NumMedia"=>"0", "From"=>"+16262444636", "FromZip"=>"91006"}  
      @message = Message.create_from_text_message(@params)
    end  

    it "creates a message" do 
      expect(@message).to be_a Message
    end

    it "creates or assigns a receiver" do 
      expect(@message.receiver).to be_a Receiver
    end

    it "assigns a text message to the time in the body" do 
      expect(@message.body).to eq @params["Body"]
    end

    it "correctly parses the time from the message" 

    it "assign's a receiver's phone number to the params entry" do 
      expect(@message.receiver.phone).to eq @params["From"]
    end

  end

end
