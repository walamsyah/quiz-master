require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    let!(:cat1) { create :category, published: false }
    let!(:cat2) { create :category, published: true }
    let!(:popular) { create :category_playing, category: cat2 }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template :index

      expect(assigns(:categories).count).to eq 1
      expect(assigns(:categories)).not_to include cat1
      expect(assigns(:categories)).to include cat2
      expect(assigns(:populars).count).to eq 1
      expect(assigns(:populars)).to include cat2
    end
  end
end
