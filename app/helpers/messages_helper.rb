module MessagesHelper
  
  def format_phone_number(phone_number)
    digits = phone_number.gsub(/\D/, '').split(//)
    if (digits.length == 11 and digits[0] == '1')
      # Strip leading 1
      digits.shift
    end
    if (digits.length == 10)
      digits = '%s%s%s' % [ digits[0,3].unshift("+1").join, digits[3,3].join, digits[6,4].join ]
    end
    return digits if digits.is_a?(String)
    digits.join
  end

  def from_twilio?
    params["From"].present?
  end
  
end
