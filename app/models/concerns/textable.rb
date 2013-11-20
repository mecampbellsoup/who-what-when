module Textable

  def create_from_sms(params)
    receiver = Receiver.find_or_create_by(:phone => params["From"])
    message = receiver.messages.create(
      :body     => parse_body_from_text_sentence(params["Body"]),
      :send_at  => parse_time_from_text_sentence(params["Body"])
    )
  end

  def parse_time_from_text_sentence(sentence)
    Chronic.parse("in #{sentence.split("in").last.strip}")
  end

  def parse_body_from_text_sentence(sentence)
    sentence.split("in").first.strip
  end

end