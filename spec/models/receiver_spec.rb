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
  end
end

=begin
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
    
    it 'parsing the sms body return by a user text message' do
      receiver = Receiver.find_by(:phone => "+17403190208")
      sentence = "this sentence has the word on this gets cutoff"
      first_keyword = receiver.locate_time_keyword(sentence)
      expect(first_keyword).to eq "on"
    end

  end

end
=end