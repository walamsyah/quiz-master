require 'rails_helper'

RSpec.describe "quizzes/show.html.slim", type: :view do
  let!(:category) { create :category }

  context "user signed in" do
    it "will show quiz detail and play button" do
      user = create :user
      sign_in user
      assign :category, category
      render

      expect(rendered).to have_selector "h1.display-4.text-center", text: category.name
      expect(rendered).to have_selector "img.img-fluid[src='#{category.image_url(:big)}']"
      expect(rendered).to have_content category.description
      expect(rendered).to have_selector "button.btn.btn-success[type=submit]", text: "LET'S PLAY NOW"
    end
  end

  context "user not signed in" do
    it "will show quiz detail and login button" do
      assign :category, category
      render

      expect(rendered).to have_selector "h1.display-4.text-center", text: category.name
      expect(rendered).to have_selector "img.img-fluid[src='#{category.image_url(:big)}']"
      expect(rendered).to have_content category.description
      expect(rendered).to have_selector "a.btn.btn-primary[href='#{new_user_session_path}']", text: "Sign In for Playing"
    end
  end
end
