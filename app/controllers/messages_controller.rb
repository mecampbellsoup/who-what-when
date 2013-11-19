class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
    TwilioWorker.perform_at(@message.send_at, @message.id)
    #TwilioWorker.perform_at(interval, *args)
    redirect_to root_path
    #end
  end

  private
    def message_params
      params.require(:message).permit(:receiver, :body, :send_at)
    end
end
