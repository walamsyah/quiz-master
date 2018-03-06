require 'rails_helper'

RSpec.describe QuizzesController, type: :controller do

  describe "GET #show" do
    context "quiz category published" do
      let!(:category) { create :category, published: true }
      
      it "returns http success" do
        get :show, params: { id: category }
        expect(response).to have_http_status(:success)
        expect(response).to render_template :show

        expect(assigns(:category)).to eq category
      end
    end

    context "quiz category unpublished" do
      let!(:category) { create :category, published: false }
      
      it "returns http not found" do
        get :show, params: { id: category }
        expect(response).to redirect_to '/404.html'
      end
    end
  end

end
