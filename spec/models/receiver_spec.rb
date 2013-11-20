require 'spec_helper'

describe Receiver do

  context 'phone number sanitization' do
    it 'parses basically every phone number into our 10-digit format' do
      receiver = Receiver.create(:phone => "+1 740 319 0208")
      expect(receiver.phone).to eq("+17403190208")
      receiver = Receiver.create(:phone => " 646 555 5553")
      expect(receiver.phone).to eq("+16465555553")
    end
  end

end
