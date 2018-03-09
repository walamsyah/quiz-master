require 'rails_helper'

RSpec.describe HistoriesController, type: :controller do
  let!(:user) { create :user }

  before do
    sign_in user
  end

  describe "GET #index" do
    let!(:history) { create :category_playing, user: user }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template :index

      expect(assigns(:histories).count).to eq 1
      expect(assigns(:histories)).to include history
    end
  end
end
