require 'rails_helper'

RSpec.describe "layouts/application.html.slim", type: :view do
  context "user not sign in" do
    it "render meanu, search bar, sign up and sign in" do
      render

      expect(rendered).to have_selector "a.blog-header-logo.text-dark[href='#{root_path}']", text: "Quiz Master"
      expect(rendered).to have_selector "a.p-2.text-muted[href='#{root_path}']", text: "Home"
      expect(rendered).to have_selector "a.p-2.text-muted[href='#{quizzes_path}']", text: "Quizzes"
      expect(rendered).to have_selector "a.p-2.text-muted[href='#{popular_path}']", text: "Popular"
      expect(rendered).to have_selector "form#search-form[action='#{search_path}'][method='get']"

      expect(rendered).to have_selector "a.btn.btn-sm.btn-info[href='#{new_user_registration_path}']", text: "Sign Up"
      expect(rendered).to have_selector "a.btn.btn-sm.btn-outline-secondary[href='#{new_user_session_path}']", text: "Sign In"
    end
  end

  context "user sign in" do
    it "render menu, search bar and user name" do
      user = create :user
      sign_in user
      
      render

      expect(rendered).to have_selector "a.blog-header-logo.text-dark[href='#{root_path}']", text: "Quiz Master"
      expect(rendered).to have_selector "a.p-2.text-muted[href='#{root_path}']", text: "Home"
      expect(rendered).to have_selector "a.p-2.text-muted[href='#{quizzes_path}']", text: "Quizzes"
      expect(rendered).to have_selector "a.p-2.text-muted[href='#{popular_path}']", text: "Popular"
      expect(rendered).to have_selector "form#search-form[action='#{search_path}'][method='get']"

      expect(rendered).not_to have_selector "a.btn.btn-sm.btn-info[href='#{new_user_registration_path}']", text: "Sign Up"
      expect(rendered).not_to have_selector "a.btn.btn-sm.btn-outline-secondary[href='#{new_user_session_path}']", text: "Sign In"

      expect(rendered).to have_content user.name
      expect(rendered).to have_selector "a.dropdown-item[href='#{edit_user_registration_path}']", text: "Profile"
      expect(rendered).to have_selector "a.dropdown-item[href='#{histories_path}']", text: "Playing History"
      expect(rendered).to have_selector "a.dropdown-item[href='#{destroy_user_session_path}']", text: "Sign Out"
    end
  end
end
