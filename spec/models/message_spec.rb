require 'spec_helper'

describe Message do
  include MessagesHelper

  before :each do
    @receiver = create(:receiver)
  end

  context 'creating new messages' do

    it 'has a method called new_message' do
      expect(@receiver).to respond_to(:new_message)
    end
    
    it 'with params["From"] will call create_from_text' do
      params = {"From" => "+17403190208", "Body" => "Body of the message in 30 seconds", "SmsSid"=>"SM37e06f9540c0943477d6a5ce974cc2fd", "To"=>"+13476948027"}  
      @message = @receiver.create_from_sms(params)
      expect { @receiver.create_from_sms(params) }.to change { Message.count }.by(1)
      expect(@message.receiver).to eq(@receiver)
    end

    it 'without params["From"] will call create_from_web' do
      params = {:body => "sdfsf", :send_at => "in 5 seconds"}
      @message = @receiver.create_from_web(params)
      expect { @receiver.create_from_web(params) }.to change { Message.count }.by(1)
      expect(@message.receiver).to eq(@receiver)
    end

    it 'cannot create a new message with no body' do
      params = { :body => "", :send_at => "in 5 seconds"}
      @message = @receiver.create_from_web(params)
      expect(Message.count).to eq 0
      expect(@message).to have(1).error_on(:body)
    end

    it 'cannot createa a time without a send_at value' do
      params = { :body => "hi buddy", :send_at => ""}
      @message = @receiver.create_from_web(params)
      expect(@message.send_at).to be_within(1).of(Time.now)
    end

  end

  context "off of a single receiver" do 
    it "does not duplicate a receiver instance" do 
      5.times do 
        params = {"From" => "+17403190208", "Body" => "Body of the message in 30 seconds", "SmsSid"=>"SM37e06f9540c0943477d6a5ce974cc2fd", "To"=>"+13476948027"}  
        @message = @receiver.create_from_sms(params)
      end
      expect(Message.count).to eq 5
      expect(Receiver.count).to eq 1
    end
  end


#   context "creating a message from a text message" do 

#     context "parsing sms replies from users" do
      
#       it "can parse the SMS body to extract reminder intervals only at in, on, until, or when" do
#         params = {"Body" => "Our #create_from_sms method should get the following time in 30 seconds"}
#       end

#     end

#     it "creates a message" do 
#       expect(@message).to be_a Message
#     end

#     it "creates or assigns a receiver" do 
#       expect(@message.receiver).to be_a Receiver
#     end

#     it "assigns a text message to the time in the body" do 
#       expect(@message.body).to eq "Body of the message"
#     end

#     it "correctly parses the time from the message" do
#       expect(@message.send_at).to be_a(Time)
#     end

#     it "assign's a receiver's phone number to the params entry" do 
#       expect(@message.receiver.phone).to eq @params["From"]
#     end

#   end

end
