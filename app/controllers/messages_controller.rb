class MessagesController < ApplicationController

  include MessagesHelper

  before_action :set_receiver, :only => [:create]

  def new
  end

  def create
    @message = @receiver.new_message(message_params)

    if @message.persisted?
      queue_message_to_be_sent(@message.send_at, @message.id)
    end
    
    render :nothing => true
  end

  private

    def message_params
      from_twilio? ? params : params.require(:message).permit(:body, :send_at, :receiver)
    end

    def set_receiver
      @receiver = if from_twilio?
        Receiver.find_or_create_by(:phone => params["From"])
      else
        Receiver.find_or_create_by(:phone => (params[:message][:receiver]))
      end
    end

    def queue_message_to_be_sent(time, message_id)
      TwilioWorker.perform_at(time, message_id)
    end

end
