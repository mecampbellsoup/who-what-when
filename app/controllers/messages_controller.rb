class MessagesController < ApplicationController

  def new
    @receiver = Receiver.new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
    TwilioWorker.perform_async("send message", @message.id)
    redirect_to root_path
    #end
  end

  private
    def message_params
      params.require(:message).permit(:receiver, :body, :send_at)
    end
end
