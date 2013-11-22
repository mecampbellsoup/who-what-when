require 'spec_helper'

describe "sending a text" do 

  it "sends a text" do 
    visit '/'
    within("#duck-form") do 
      fill_in '#phone_input', :with => ''
      fill_in '#message_body', :with => 'Remind me about the game'
      fill_in '#message_send_at', :with => 'now'
    end
    binding.pry
    click_link '#submit_button'
  end

end