class Receiver < ActiveRecord::Base
  has_many :messages
  before_create :format_phone_number

  validates :phone, length: { minimum: 10, :too_short => "digits ain't right - please enter at least %{count} of them" }

  include Textable

  private

    def format_phone_number
      if self.phone
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

end
