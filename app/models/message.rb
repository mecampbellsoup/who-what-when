class Message < ActiveRecord::Base
  belongs_to :receiver

  def receiver=(phone_number)
    @receiver_id = Receiver.find_or_create_by(:phone => phone_number).id
    write_attribute :receiver_id, @receiver_id
  end

  def send_at=(date)
    if date.is_a?(Time)
      write_attribute :send_at, date
    else
      date = Chronic.parse(date) || Time.now
      write_attribute :send_at, date
    end
  end

  def self.create_from_text_message(params)

    @message = Message.new
    @message.update(:receiver => params["From"],
                    :body     => parse_body_from_text_sentence(params["Body"]),
                    :send_at  => parse_time_from_text_sentence(params["Body"])
    )
    @message
  end

  def self.parse_time_from_text_sentence(sentence)
    Chronic.parse("in #{sentence.split("in").last.strip}")
  end

  def self.parse_body_from_text_sentence(sentence)
    sentence.split("in").first.strip
  end


end
