class SmsTimeValidator < ActiveModel::Validator

  def validate(record)
    if record.send_at.class != Time
      record.errors[:send_at] << "Hello! You didn't send us a time. Please send again."
    end
  end
end
