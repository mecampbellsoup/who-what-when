class Message < ActiveRecord::Base
  belongs_to :receiver
  extend Textable

  def send_at=(date)
    if !date.is_a?(Time)
      date = Chronic.parse(date) || Time.now
    end
    write_attribute :send_at, date
  end

  def self.create_from_web(message_params)
    receiver = Receiver.find_or_create_by(
      :phone => format_phone_number(message_params[:receiver])
    )
    message = receiver.messages.create do |m|
      m.body = message_params["body"]
      m.send_at = message_params["send_at"]
    end
  end

  def self.create_from_text_message(params)
    receiver = Receiver.find_or_create_by(:phone => params["From"])
    message = receiver.messages.create(
      :body => parse_body_from_text_sentence(params["Body"]),
      :send_at => parse_time_from_text_sentence(params["Body"])
      )
  end
end