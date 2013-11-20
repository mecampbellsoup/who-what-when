class Receiver < ActiveRecord::Base
  has_many :messages
  after_save :format_phone_number

  def build_from_message(phone_number)
    # this method takes a phone number string and
    # finds or builds a Receiver object
    @id = Receiver.find_or_create_by(:phone => phone_number).id
    write_attribute :id, @id
  end

  private

    def format_phone_number
      digits = self.phone.gsub(/\D/, '').split(//)
      if (digits.length == 11 and digits[0] == '1')
        # Strip leading 1
        digits.shift
      end
      if (digits.length == 10)
        digits = '%s%s%s' % [ digits[0,3].unshift("+1").join, digits[3,3].join, digits[6,4].join ]
      end
      self.phone = digits
    end

end
