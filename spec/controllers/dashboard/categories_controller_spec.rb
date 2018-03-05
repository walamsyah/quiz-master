require 'rails_helper'

RSpec.describe Dashboard::CategoriesController, type: :controller do

  let!(:category) { create :category }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:categories)).to be_present
      expect(assigns(:categories)).to be_include category
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template :new
      expect(assigns(:category)).to be_a_new_record
    end
  end

  describe "POST #create" do
    it "create a question when params valid" do
      category_attributes = attributes_for :category
      post :create, params: { category: category_attributes }

      expect(assigns(:category)).to be_persisted
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to match /quiz category was successfully created/i
    end

    it "failed to create a question when params not valid" do
      post :create, params: { category: { name: nil, description: "Description Test", published: "true" } }

      expect(assigns(:category)).not_to be_persisted
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: category.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:category)).to eq category
    end
  end

  describe "PATCH #update" do
    it "redirect to index when success" do
      patch :update, params: { id: category.id, category: { name: "new name", published: true } }

      expect(flash[:notice]).to match /quiz category was successfully updated/i
      expect(response).to redirect_to dashboard_categories_path
    end

    it "render edit when failed" do
      patch :update, params: { id: category.id, category: { name: nil, published: true } }

      expect(response).to render_template :edit
    end
  end

  describe "DELETE #destroy" do
    it "redirect to index with falsh notice" do
      delete :destroy, params: { id: category.id }

      expect(flash[:notice]).to match /quiz category was successfully deleted/i
      expect(response).to redirect_to dashboard_categories_path
    end
  end

end
