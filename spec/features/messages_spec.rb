require 'spec_helper'

describe "sending a text" do 

  it "sends a text" do 
    visit root_path

      fill_in 'phone_input', :with => '6262444636'
      fill_in 'message_body', :with => 'Remind me about the game'
      fill_in 'message_send_at', :with => 'now'
      
      expect{
        click_button 'submit_button'
      }.to change { Message.count }.by(1)
  end

  it "shouldn't send a text with bad user data" do 
    visit root_path

      fill_in 'phone_input', :with => '2444636'
      fill_in 'message_body', :with => 'Remind me about the game'
      fill_in 'message_send_at', :with => 'now'
      
      expect{
        click_button 'submit_button'
      }.to raise_exception ActiveRecord::RecordNotSaved
  end

end