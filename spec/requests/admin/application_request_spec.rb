require 'rails_helper'

RSpec.describe "Admin::Applications", type: :request do

  describe "GET /" do
    let(:user) { FactoryBot.create(:user) }
    let(:admin) { FactoryBot.create(:user, :admin) }

    context "when sign in as a user" do
      before do
        login_as(user)
      end

      it "redirect away" do
        get "/admin"
        expect(response).to have_http_status(302)
        follow_redirect!
        expect(response.body).to include "You must be an admin to do that."
      end
    end

    context "when signed in as admin" do
      before do
        login_as(admin)
      end
      
      it "lets the admin in" do
        get "/admin"
        expect(response).to have_http_status(:success)
      end
    end
  end

end
