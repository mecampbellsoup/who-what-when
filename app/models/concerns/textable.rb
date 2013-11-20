module Textable

  TimeKeywords = ["in", "on", "when", "until"]

  def locate_time_keyword(sentence)
    TimeKeywords.each do |w|
      next if !sentence.index(w)
      return sentence[sentence.index(w), w.length]
    end
  end

  def parse_text_body_at_keyword(sentence)
    sentence.split(locate_time_keyword(sentence)).first.strip
  end

  def parse_text_time_at_keyword(sentence)
    Chronic.parse("in #{sentence.split(locate_time_keyword(sentence)).last.strip}")
  end

  # def self.included(base)
  #   base.extend(ClassMethods)
  # end

  def create_from_sms(params)
    message  = messages.create(
      :body     => parse_text_body_at_keyword(params["Body"]),
      :send_at  => parse_text_time_at_keyword(params["Body"])
    )
  end

end