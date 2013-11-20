class MessagesController < ApplicationController
  
  include MessagesHelper

  def new
    @message = Message.new
  end

  def create
    @receiver = Receiver.find_or_create_by(:phone => format_phone_number(params[:message][:receiver]))
    @message = @receiver.messages.create(message_params)
    TwilioWorker.perform_at(@message.send_at, @message.id)
    redirect_to root_path
  end

  def create_from_reply
    @message = Message.create_from_sms(params)
    TwilioWorker.perform_at(@message.send_at, @message.id)
    render :nothing
  end


  private
    def message_params
      params.require(:message).permit(:body, :send_at)
    end
end
