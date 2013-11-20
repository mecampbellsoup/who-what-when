require 'spec_helper'

describe Message do
  include MessagesHelper

  context 'creating new messages' do
    before :each do
      @receiver = FactoryGirl.create(:receiver)
    end

    it 'has a method called new_message' do
      expect(@receiver).to respond_to(:new_message)
    end

    it 'with params["From"] will call create_from_text' do
      params = {"From" => "+17403190208", "Body" => "Body of the message in 30 seconds", "SmsSid"=>"SM37e06f9540c0943477d6a5ce974cc2fd", "To"=>"+13476948027"}  
      @message = @receiver.new_message(params)
      expect { @receiver.new_message(params) }.to change { Message.count }.by(1)
      expect(@message.receiver).to be(@receiver)
    end

    it 'without params["From"] will call create_from_web'
    
  end


#   context "creating a message from the website" do
    
#     let(:message) { receiver.messages.build(:body => "sdfsf", :send_at => "in 5 seconds") }

#     before(:each) do
#       receiver.save
#       message.save
#     end

#     it "creates a message" do 
#       expect(message).to be_a Message
#     end

#     it "creates or assigns a receiver" do 
#       expect(message.receiver).to be_a(Receiver)
#     end

#     it "assigns the message body to the params form" do 
#       expect(message.body).to eq "sdfsf"
#     end
#   end

#   context "multiple messages to the same receiver" do 
#     it "does not duplicate a receiver instance" do 
#       5.times do 
#         message = Message.create(:receiver => Receiver.find_or_create_by(:phone => format_phone_number("740-319-0208")))
#       end
#       expect(Message.count).to eq 5
#       expect(Receiver.count).to eq 1
#     end
#   end


#   context "creating a message from a text message" do 

#     before :each do 
#       @receiver = Receiver.find_or_create_by(:phone => @params["From"])
#       @message = @receiver.messages.create_from_sms(@params)
#     end

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

# end
