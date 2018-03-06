require 'rails_helper'

RSpec.describe "home/index.html.slim", type: :view do
  context "default render" do
    it "render welcome message" do
      render
      expect(rendered).to have_selector ".jumbotron.p-3.p-md-5.text-white.rounded.bg-dark"
      expect(rendered).to have_selector "h1.display-4.font-italic", text: "Welcome to Quiz Master"
      expect(rendered).to have_selector "p.lead.my-3", text: "You can play a variety of educational and entertaining quizzes just here"
    end
  end

  context "@categories not present" do
    it "will not render quiz list" do
      render
      expect(rendered).not_to have_selector "h3.font-italic.border-bottom", text: "Latest Quizzes"
    end
  end

  context "@categories present" do
    it "will render quiz list" do
      category = create :category
      assign :categories, [category]
      render

      expect(rendered).to have_selector "h3.font-italic.border-bottom", text: "Latest Quizzes"
      expect(rendered).to have_selector "a[href='#{quiz_path(category)}'] img.card-img-top[src='#{category.image_url(:medium)}']"
      expect(rendered).to have_selector "p.card-text", text: category.name
      expect(rendered).to have_selector "a[href='#{quiz_path(category)}'] button.btn.btn-sm.btn-outline-secondary[type=button]", text: "Play Now"
      expect(rendered).to have_selector "small.text-muted", text: "#{category.total_questions} questions"
    end
  end
end
