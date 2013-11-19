class MessagesController < ApplicationController

  def new
    @receiver = Receiver.new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      TwilioWorker.perform_at(@message.send_at, @message.id)
      binding.pry
      redirect_to new_message_path
    end
  end

  private
    def message_params
      params.require(:message).permit(:receiver, :body, :send_at)
    end
end
