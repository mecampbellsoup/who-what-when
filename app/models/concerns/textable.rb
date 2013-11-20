module Textable

  def create_from_text_message(params)
    @message = Message.new
    @message.update(
      :receiver => params["From"],
      :body     => parse_body_from_text_sentence(params["Body"]),
      :send_at  => parse_time_from_text_sentence(params["Body"])
    )
    @message
  end

  def parse_time_from_text_sentence(sentence)
    Chronic.parse("in #{sentence.split("in").last.strip}")
  end

  def parse_body_from_text_sentence(sentence)
    sentence.split("in").first.strip
  end

end