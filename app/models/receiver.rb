class Receiver < ActiveRecord::Base
  has_many :messages
  before_save :format_phone_number

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
