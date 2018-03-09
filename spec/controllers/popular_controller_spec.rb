require 'rails_helper'

RSpec.describe PopularController, type: :controller do
  describe "GET #index" do
    let!(:playing) { create :category_playing }

    it "returns http success" do
      get :index

      expect(response).to have_http_status(:success)
      expect(response).to render_template :index

      expect(assigns(:categories).size).to eq 1
      expect(assigns(:categories)).to include playing.category
    end
  end
end
