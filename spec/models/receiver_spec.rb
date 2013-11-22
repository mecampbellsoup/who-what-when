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

    #let(:sentence) { "go shopping in 3 seconds" }

    let(:body) {
      receiver.parse_text_body_at_keyword(sentence)
    }
      
    let(:time) {
      receiver.parse_text_time_at_keyword(sentence)
    }

    let(:receiver) { create(:receiver) }

    @failing_sentences =
      [
        "this sentencone hinas the word this gets cutoff",
        "go shopping 3 seconds",
        "reminond me it's sunday",
        "only remind me thursday",
        "go shopping Thursday",
        "don't re-until-mind me Friday"
      ]

    @failing_sentences.each do |sentence|
      context sentence do
        
        let(:sentence) { sentence }

        it 'should fail' do
          expect(body).to eq false
          expect(time).to eq false
        end
      end
    end

    context "this sentence indeed has the word on thursday" do |s|

      let(:sentence) { s.description }

      it 'parsing the sms body & time with valid time following the keyword' do
        expect(body).to eq "this sentence indeed has the word"
        expect(time.thursday?).to be true
      end
    end

    context "go shopping in 3 seconds" do |s|

      let(:sentence) { s.description }

      it 'parsing the sms body & time with valid time following the keyword' do
        expect(body).to eq "go shopping"
        expect(time).to be_within(0.01).of(Time.now + 3)
      end
    end

    context "reminond me when it's sunday" do |s|

      let(:sentence) { s.description }

      it 'parsing the body with multiple timewords returns the first match' do
        expect(body).to eq "reminond me"
        expect(time.sunday?).to be true
      end
    end

    context "only remind me on thursday" do |s|

      let(:sentence) { s.description }

      it 'parsing the sms body & time with valid time following the keyword' do
        expect(body).to eq "only remind me"
        expect(time.thursday?).to be true
      end
    end

    context "go shopping on saturday" do |s|

      let(:sentence) { s.description }

      it 'parsing the sms body & time with valid time following the keyword' do
        expect(body).to eq "go shopping"
        expect(time.saturday?).to be true
      end
    end

    context "don't remind me until Friday" do |s|

      let(:sentence) { s.description }

      it 'parsing the sms body & time with valid time following the keyword' do
        expect(body).to eq "don't remind me"
        expect(time.friday?).to be true
      end
    end

  end

end
