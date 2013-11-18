class MessagesController < ApplicationController

  def new
    @receiver = Receiver.new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
    if @message.send!
      redirect_to new_message_path
    end
  end

  private
    def message_params
      params.require(:message).permit(:receiver, :body, :send_at)
    end
end
