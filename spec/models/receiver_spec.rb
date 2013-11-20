require 'spec_helper'

describe Receiver do

  context 'phone number sanitization' do
    it 'parses basically every phone number into our 10-digit format' do
      receiver = Receiver.new(:phone => "740 319 0208")
      receiver.save
      expect(receiver.phone).to eq("+17403190208")
      receiver = Receiver.new(:phone => "1 646 555 5553")
      receiver.save
      expect(receiver.phone).to eq("+16465555553")
    end

    it 'is valid only if its phone contains at least 10 digits' do
      receiver = Receiver.new(:phone => "(740) 319-0208")
      expect { receiver.save }.to change { Receiver.count }.by(1)
    end

    it 'is invalid if its phone does not contain 10 digits' do
      receiver = Receiver.new(:phone => "319-0208")
      expect(receiver).to have(1).error_on(:phone)
      expect { receiver.save! }.to raise_exception ActiveRecord::RecordInvalid
      expect(receiver.errors.full_messages).to include("Phone digits ain't right - please enter at least 10 of them")
    end

  end

end
