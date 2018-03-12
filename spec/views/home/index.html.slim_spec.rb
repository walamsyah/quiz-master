require 'rails_helper'

RSpec.describe "home/index.html.slim", type: :view do
  context "default render" do
    it "render carousel" do
      render
      expect(rendered).to have_selector "#carouselQuiz"
      
      expect(rendered).to have_selector "h1.display-4.font-italic", text: "Welcome to Quiz Master"
      expect(rendered).to have_selector "p.lead.my-3", text: "You can play a variety of educational and entertaining quizzes just here"
      
      expect(rendered).to have_selector "h1.display-4.font-italic", text: "Rich of Features"
      expect(rendered).to have_selector "p.lead.my-3", text: "You can search quizzes, see your played quiz history and more"

      expect(rendered).to have_selector "h1.display-4.font-italic", text: "Easy Manage"
      expect(rendered).to have_selector "p.lead.my-3", text: "Manage quizzes from admin dashboard make it simple"
    end
  end

  context "Section Popular Quizzes" do
    context "@populars not present" do
      it "will not render quiz list" do
        render
        expect(rendered).not_to have_selector "h3.font-italic.border-bottom", text: "Popular Quizzes"
      end
    end

    context "@populars present" do
      it "will render quiz list" do
        category = create :category
        assign :populars, [category]
        render

        expect(rendered).to have_selector "h3.font-italic.border-bottom", text: "Popular Quizzes"
        expect(rendered).to have_selector "a[href='#{quiz_path(category)}'] img.card-img-top[src='#{category.image_url(:medium)}']"
        expect(rendered).to have_selector "p.card-text", text: category.name
        expect(rendered).to have_selector "a[href='#{quiz_path(category)}'] button.btn.btn-sm.btn-outline-secondary[type=button]", text: "Play Now"
        expect(rendered).to have_selector "small.text-muted", text: "#{category.total_questions} questions"
      end
    end
  end

  context "Section Latest Quizzes" do
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
end
