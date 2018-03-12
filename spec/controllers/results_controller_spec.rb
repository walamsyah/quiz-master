require 'rails_helper'

RSpec.describe ResultsController, type: :controller do
  describe "GET #show" do
    let!(:token) { '123456' }
    let!(:history) { create :question_answer, category_token: token }

    it "returns http success" do
      get :show, params: { id: token }

      expect(response).to have_http_status(:success)
      expect(response).to render_template :show

      expect(assigns(:results).size).to eq 1
      expect(assigns(:results)).to include history
    end
  end
end
