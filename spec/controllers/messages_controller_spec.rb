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
          xhr :post, :create, {:message => attributes_for(:message).merge(:receiver => '917-753-3666')}
        }.to change{ Message.count }.by(1)
        expect(response.code).to eq("200")
      end
    end

    context "with invalid attributes" do
      it "does not save the new message" do
        expect{
          post :create, {:message => attributes_for(:invalid_message).merge(:receiver => '917-753-3666')}
        }.to_not change{ Message.count }
      end

      # it "re-renders the new method" do
      #   post :create, contact: Factory.attributes_for(:invalid_contact)
      #   response.should render_template :new
      # end
    end

  end
end
