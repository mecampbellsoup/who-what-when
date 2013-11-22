class Receiver < ActiveRecord::Base
  
  before_validation :find_or_create_formatted_phone_number
  validates :phone, :uniqueness => true
  validates :phone,
    { 
      length: { 
        minimum: 10, too_short: "digits ain't right - please enter at least %{count} of them"
      },
      format: { 
        with: /(\+1?)(?:\+?|\b)[0-9]{10}\b/, message: "phone number must be standard format"
      }
    }

  has_many :messages

  include Textable

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
    end
    
    if digits.is_a?(String)
      self.phone = digits
    else
      self.phone = digits.join
    end
  end

  private

    def find_or_create_formatted_phone_number
      found = Receiver.find_by(:phone => self.format_phone_number)
      return found if found
      self
    end

end
