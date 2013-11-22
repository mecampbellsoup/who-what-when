require 'spec_helper'

describe "sending a text" do 

  it "sends a text" do
    visit root_path
    within("form") do 
      fill_in "phone_input", :with => '(740)319-0208'
      fill_in 'message_body', :with => 'Remind me about the game'
      fill_in 'message_send_at', :with => 'now'
    end
    expect{
      click_button 'submit_button'
    }.to change { Message.count }.by(1)
  end

end