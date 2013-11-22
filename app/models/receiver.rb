class Receiver < ActiveRecord::Base
  has_many :messages
  before_validation :find_or_create_formatted_phone_number
  validates_uniqueness_of :phone

  validates :phone, length: { 
    minimum: 10, 
    too_short: "digits ain't right - please enter at least %{count} of them"
  }

  include Textable

  private

    def format_phone_number
      if self.phone && self.phone.is_a?(String)
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

    def find_or_create_formatted_phone_number
      self.format_phone_number
      found = Receiver.find_by(:phone => self.phone)
      if found
        return found
      else
        Receiver.create(:phone => self.phone)
    end

end
