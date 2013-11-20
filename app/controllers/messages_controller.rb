class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create_from_web
    @message = Message.create_from_web(message_params)
    TwilioWorker.perform_at(@message.send_at, @message.id)
    redirect_to root_path
  end

  def create_from_text_message
    @message = Message.create_from_text_message(params)
    TwilioWorker.perform_at(@message.send_at, @message.id)
    render :nothing => true
  end


  private
    def message_params
      params.require(:message).permit(:body, :send_at, :receiver )
    end
end
