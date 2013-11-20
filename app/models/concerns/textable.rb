module Textable

  def format_phone_number(phone_number)
    digits = phone_number.gsub(/\D/, '').split(//)
    if (digits.length == 11 and digits[0] == '1')
      # Strip leading 1
      digits.shift
    end
    if (digits.length == 10)
      digits = '%s%s%s' % [ digits[0,3].unshift("+1").join, digits[3,3].join, digits[6,4].join ]
    end
    digits
  end
  
  def parse_time_from_text_sentence(sentence)
    Chronic.parse("in #{sentence.split("in").last.strip}")
  end

  def parse_body_from_text_sentence(sentence)
    sentence.split("in").first.strip
  end

end

