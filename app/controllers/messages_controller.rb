class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create_from_web
    @receiver = Receiver.find_or_create_by(:phone => format_phone_number(message_params[:receiver]))
    @message = @receiver.messages.create_from_web(message_params, @receiver)
    TwilioWorker.perform_at(@message.send_at, @message.id)
    redirect_to root_path
  end

  def create_from_text_message
    @receiver = Receiver.find_or_create_by(:phone => format_phone_number(params["From"]))
    @message = @receiver.messages.create_from_sms(params, @receiver)
    TwilioWorker.perform_at(@message.send_at, @message.id)
    render :nothing => true
  end


  private
    def message_params
      params.require(:message).permit(:body, :send_at)
    end
end
