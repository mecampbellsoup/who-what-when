require 'spec_helper'

describe Receiver do

  context 'phone number sanitization' do

    it "removes spaces and adds a +" do 
      receiver = Receiver.create(:phone => "1 646 555 5553")
      expect(receiver.phone).to eq("+16465555553")
    end

    it "removes spaces and adds a +1" do 
      receiver = Receiver.create(:phone => "646 555 5553")
      expect(receiver.phone).to eq("+16465555553")
    end

    it "rejects numbers with less than ten digits" do 
      receiver = Receiver.new(:phone => "123")
      expect(receiver).to have(1).error_on(:phone)
    end

    it "truncates numbers with more than ten digits" do 
      receiver = Receiver.new(:phone => "555 555 5555 555")
      expect(receiver.phone).to have_at_least(1).error_on(:phone)
    end

    it "rejects numbers which contain non-numerical characters" do 
      receiver = Receiver.new(:phone => "1dfgdg234sfsf456sdf7890")
      expect(receiver.phone).to have_at_least(1).error_on(:phone)
    end
    
    it 'parses basically every phone number into our 10-digit format' do
      receiver = Receiver.new(:phone => "1 646 555 5553")
      receiver.save
      expect(receiver.phone).to eq("+16465555553")
    end

    it 'is valid only if its phone contains at least 10 digits' do
      receiver = Receiver.new(:phone => "(212) 646-0734")
      expect { receiver.save }.to change { Receiver.count }.by(1)
    end

    it 'is invalid if its phone does not contain 10 digits' do
      receiver = Receiver.new(:phone => "319-0208")
      expect(receiver).to have(1).error_on(:phone)
      expect { receiver.save! }.to raise_exception ActiveRecord::RecordInvalid
      expect(receiver.errors.full_messages).to include("Phone digits ain't right - please enter at least 10 of them")
    end

  end

  context Textable do

    include Textable
    
    before :each do
      @receiver = create(:receiver)
    end

    it 'parsing the sms body return by a user text message' do
      sentence = "this sentence has the word on this gets cutoff"
      first_keyword = @receiver.locate_time_keyword(sentence)
      expect(first_keyword).to eq "on"
    end

    it 'parsing the body with timewords inside other words does not return a match' do
      sentence = "go shopping in 3 seconds"
      body = @receiver.parse_text_body_at_keyword(sentence)
      time = @receiver.parse_text_time_at_keyword(sentence)
      expect(body).to eq "go shopping"
      expect(time).to be_within(0.05).of(Time.now + 3)

      sentence = "reminond me when it's sunday"
      body = @receiver.parse_text_body_at_keyword(sentence)
      time = @receiver.parse_text_time_at_keyword(sentence)
      expect(body).to eq "reminond me"
      expect(time.sunday?).to be true

      sentence = "only remind me on thursday"
      body = @receiver.parse_text_body_at_keyword(sentence)
      time = @receiver.parse_text_time_at_keyword(sentence)
      expect(body).to eq "only remind me"
      expect(time.thursday?).to be true

      sentence = "go shopping on Thursday"
      body = @receiver.parse_text_body_at_keyword(sentence)
      time = @receiver.parse_text_time_at_keyword(sentence)
      expect(body).to eq "go shopping"
      expect(time.thursday?).to be true

      sentence = "don't remind me until Friday"
      body = @receiver.parse_text_body_at_keyword(sentence)
      time = @receiver.parse_text_time_at_keyword(sentence)
      expect(body).to eq "don't remind me"
      expect(time.friday?).to be true
    end
    
    it 'parsing the body with multiple timewords returns the first match' do
      sentence = "remind me because nothing inside ontime"
      first_keyword = @receiver.locate_time_keyword(sentence)
      expect(first_keyword).to eq false
    end

  end

end
