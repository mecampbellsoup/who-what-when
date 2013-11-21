class MessagesController < ApplicationController
  include MessagesHelper

  before_action :set_receiver, :only => [:create]

  def new
    @message = Message.new
  end

  def create
    @message = @receiver.new_message(message_params)

    respond_to do |format|
      if @message.persisted? && !from_twilio?
        format.html { redirect_to root_path, :success => "Reminder sent!" }
        format.js {}
      elsif !@message.persisted?
        format.html { render :new, :error => @message.errors.full_messages }
        format.js {}
      end
    end
    # make delegation method for this
    TwilioWorker.perform_at(@message.send_at, @message.id)
    
    if from_twilio?
      render :nothing => true
    else
      
    end
  end

  private

    def message_params
      from_twilio? ? params : params.require(:message).permit(:body, :send_at)
    end

    def set_receiver
      @receiver = if from_twilio?
        Receiver.find_or_create_by(:phone => params["From"])
      else
        Receiver.find_or_create_by(:phone => (params[:message][:receiver]))
      end
    end
end
