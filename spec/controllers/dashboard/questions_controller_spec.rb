require 'rails_helper'

RSpec.describe Dashboard::QuestionsController, type: :controller do

  let!(:admin) { create :user, role: 'admin' }
  let!(:category) { create :category }
  let!(:question) { create :question, category: category }
  
  before do
    sign_in admin
  end
  
  describe "GET #index" do
    let!(:category2) { create :category }
    let!(:question2) { create :question, category: category2 }
    
    context "params[:category_id] not present" do
      it "not filter questions by category" do
        get :index
        expect(response).to have_http_status(:success)
        expect(assigns(:questions).count).to eq 2
        expect(assigns(:questions)).to be_include question
        expect(assigns(:questions)).to be_include question2
      end
    end

    context "params[:category_id] present" do
      it "filter questions by category" do
        get :index, params: { category_id: category.id }
        expect(response).to have_http_status(:success)
        expect(assigns(:questions).count).to eq 1
        expect(assigns(:questions)).to be_include question
        expect(assigns(:questions)).not_to be_include question2
      end
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template :new
      expect(assigns(:question)).to be_a_new_record
    end
  end

  describe "POST #create" do
    it "create a question when params valid" do
      post :create, params: { question: { answer: "question", content: "Description Test", published: "true", position: "5", category_id: category.id } }

      expect(assigns(:question)).to be_persisted
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to match /quiz question was successfully created/i
    end

    it "failed to create a question when params not valid" do
      post :create, params: { question: { answer: nil, content: "Description Test", published: "true", position: "5" } }

      expect(assigns(:question)).not_to be_persisted
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: question.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:question)).to eq question
    end
  end

  describe "PATCH #update" do
    it "redirect to index when success" do
      patch :update, params: { id: question.id, question: { content: "new content", published: true } }

      expect(flash[:notice]).to match /quiz question was successfully updated/i
      expect(response).to redirect_to dashboard_questions_path
    end

    it "render edit when failed" do
      patch :update, params: { id: question.id, question: { content: nil, published: true } }

      expect(response).to render_template :edit
    end
  end

  describe "DELETE #destroy" do
    it "redirect to index with falsh notice" do
      delete :destroy, params: { id: question.id }

      expect(flash[:notice]).to match /quiz question was successfully deleted/i
      expect(response).to redirect_to dashboard_questions_path
    end
  end

end
