require 'rails_helper'

RSpec.describe Dashboard::UsersController, type: :controller do

  let!(:user_admin) { create :user, role: 'admin' }
  let!(:user_member) { create :user, role: 'member' }

  before do
    sign_in user_admin
  end
  
  describe "GET #index" do
    context "params[:role] not present" do
      it "not filter users by category" do
        get :index
        expect(response).to have_http_status(:success)
        expect(assigns(:users).count).to eq 2
        expect(assigns(:users)).to be_include user_admin
        expect(assigns(:users)).to be_include user_member
      end
    end

    context "params[:role] present" do
      it "filter users by category" do
        get :index, params: { role: 'member' }
        expect(response).to have_http_status(:success)
        expect(assigns(:users).count).to eq 1
        expect(assigns(:users)).to be_include user_member
        expect(assigns(:users)).not_to be_include user_admin
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: user_member.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq user_member
    end
  end

  describe "PATCH #update" do
    it "redirect to index with flash notice" do
      patch :update, params: { id: user_member.id, user: { role: "admin" } }

      expect(flash[:notice]).to match /user was successfully updated/i
      expect(response).to redirect_to dashboard_users_path
    end
  end

  describe "DELETE #destroy" do
    it "redirect to index with flash notice" do
      delete :destroy, params: { id: user_member.id }

      expect(flash[:notice]).to match /user was successfully deleted/i
      expect(response).to redirect_to dashboard_users_path
    end
  end

end
