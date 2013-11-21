require 'spec_helper'

describe MessagesController do

  describe 'GET #new' do
    it 'renders the :new view' do
      get :new
      expect(response).to be_ok
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with form attributes" do

      it "redirects to the new page" do
        expect{
          post :create, :message => FactoryGirl.attributes_for(:message)
        }.to change{ Message.count }.by(1)
        response.should redirect_to root_path
      end
    end

  end
end
