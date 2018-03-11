require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe "GET #index" do
    context "have result" do
      it "will return @categories = present and @populars = nil" do
        category = create :category, name: "All About Jakarta"

        get :index, params: { q: 'jakarta' }

        expect(response).to have_http_status(:success)
        expect(response).to render_template :index

        expect(assigns(:categories).size).to eq 1
        expect(assigns(:categories)).to include category

        expect(assigns(:populars)).to be_nil
      end
    end

    context "no have result" do
      it "will return @categories = nil and @populars = present" do
        category = create :category, name: "All About Jakarta"
        create :category_playing, category: category

        get :index, params: { q: 'borneo' }

        expect(response).to have_http_status(:success)
        expect(response).to render_template :index

        expect(assigns(:categories)).not_to be_present

        expect(assigns(:populars).size).to eq 1
        expect(assigns(:populars)).to include category
      end
    end
  end
end
