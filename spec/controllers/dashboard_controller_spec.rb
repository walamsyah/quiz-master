require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let!(:admin) { create :user, role: 'admin' }

  before do
    sign_in admin
  end
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template :index
    end
  end
end
