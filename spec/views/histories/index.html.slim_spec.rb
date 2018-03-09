require 'rails_helper'

RSpec.describe "histories/index.html.slim", type: :view do
  context "history not present" do
    it "will render 'PLAY NOW' button" do
      assign :histories, []
      render

      expect(rendered).to have_selector "h1", text: "History of Playing Quizzes"
      expect(rendered).to have_selector "h3.text-center", text: "It looks like you've never played quiz"
      expect(rendered).to have_selector "a.btn.btn-primary[href='#']", text: "PLAY NOW"
    end
  end

  context "history present"
end
