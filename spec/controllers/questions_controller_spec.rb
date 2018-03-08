require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe "POST #start" do
    context "quiz category is unpublished" do
      let!(:category) { create :category, published: false }
      
      it "returns http not found" do
        post :start, params: { quiz_id: category }
        expect(response).to redirect_to '/404.html'
      end
    end
    
    context "quiz category is published" do
      let!(:category) { create :category, published: true }
      let!(:question) { create :question, category: category, published: true }
      
      it "returns http success" do
        get :start, params: { quiz_id: category }
        expect(response).to have_http_status(:success)
        expect(response).to render_template :start

        expect(assigns(:category)).to eq category
        expect(assigns(:questions)).to include question
        expect(assigns(:next_page)).to eq 2
      end
    end
  end

  describe "POST #create" do
    context "quiz category is unpublished" do
      let!(:category) { create :category, published: false }
      
      it "returns http not found" do
        post :create, params: { quiz_id: category }
        expect(response).to redirect_to '/404.html'
      end
    end
    
    context "quiz category is published" do
      let!(:category) { create :category, published: true }
      let!(:question1) { create :question, category: category, published: true, position: 1 }
      let!(:question2) { create :question, category: category, published: true, position: 2 }
      let!(:question3) { create :question, category: category, published: true, position: 3 }
      let!(:token) { "123456" }

      context "params page=2" do
        it "returns http success and render start template" do
          get :create, params: { quiz_id: category, page: 2, category_token: token, question_id: question1.id, answer: "true" }
          
          expect(response).to have_http_status(:success)
          expect(response).to render_template :start

          expect(assigns(:category)).to eq category
          expect(assigns(:questions)).to include question2
          expect(assigns(:next_page)).to eq 3
          expect(assigns(:results)).not_to be_present
        end
      end

      context "params page=3" do
        it "returns http success and render _result template" do
          get :create, params: { quiz_id: category, page: 3, category_token: token, question_id: question2.id, answer: "true" }
          
          expect(response).to have_http_status(:success)
          expect(response).to render_template :start

          expect(assigns(:category)).to eq category
          expect(assigns(:questions)).to include question3
          expect(assigns(:next_page)).to eq 4
          expect(assigns(:results)).not_to be_present
        end
      end

      context "params page=4" do
        it "returns http success and render _result template" do
          get :create, params: { quiz_id: category, page: 4, category_token: token, question_id: question3.id, answer: "true" }

          expect(response).to have_http_status(:success)
          expect(response).to render_template :_result

          expect(assigns(:category)).to eq category
          expect(assigns(:questions)).to eq []
          expect(assigns(:next_page)).not_to be_present
          expect(assigns(:results)).to be_present
        end
      end
    end
  end
end
