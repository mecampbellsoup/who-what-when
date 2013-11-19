require 'spec_helper'

describe Receiver do
  
  let(:receiver) { Receiver.new }
  let(:message) { Message.new }

  context 'phone number sanitization' do
    it 'parses basically every phone number into our 10-digit format' do
      subject.update(:phone => "+1 740 319 0208")
      expect(subject.phone).to eq("+17403190208")
      subject.update(:phone => " 646 555 5553")
      expect(subject.phone).to eq("+16465555553")
    end
  end

end
