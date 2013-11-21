module Textable

  TimeKeywords = ["in", "on", "when", "until"]

  def locate_time_keyword(sentence)

    keyword = TimeKeywords.each do |w|
      next if !sentence.index(/\s#{w}\s/)
      return sentence[sentence.index(w), w.length] 
    end

    false if keyword.is_a?(Array) 
  end

  def parse_text_body_at_keyword(sentence)
    if locate_time_keyword(sentence) 
      sentence.split(locate_time_keyword(sentence)).first.strip
    else
      nil
    end
  end

  def parse_text_time_at_keyword(sentence)
    if locate_time_keyword(sentence) 
      Chronic.parse("#{locate_time_keyword(sentence)} #{sentence.split(locate_time_keyword(sentence)).last.strip}")
    else
      nil
    end
  end

  def new_message(params)
    from_twilio?(params) ? create_from_sms(params) : create_from_web(params)
  end
  
  def create_from_sms(params)
    self.messages.create(
      :body     => parse_text_body_at_keyword(params["Body"]),
      :send_at  => parse_text_time_at_keyword(params["Body"])
    )
  end

  def create_from_web(params)
    self.messages.create(
      :body => params[:body],
      :send_at => params[:send_at]
    )
  end

  def from_twilio?(params)
    params["From"].present?
  end


end