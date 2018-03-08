require 'rails_helper'

RSpec.describe "questions/_result.html.slim", type: :view do
  let!(:category) { create :category }

  context "@results is not present" do
    it "will not show results list" do
      assign :category, category
      assign :results, []

      render

      expect(rendered).not_to have_selector "th[scope='col']", text: "Question"
      expect(rendered).not_to have_selector "th[scope='col']", text: "Your Answer"
      expect(rendered).not_to have_selector "th[scope='col']", text: "Result"

      expect(rendered).to have_selector "a.btn.btn-success[href='#{quiz_path(category)}']"
    end
  end

  context "@results is present" do
    it "will show results list" do
      question_answer = create :question_answer

      assign :category, category
      assign :results, [question_answer]

      render

      expect(rendered).to have_selector "th[scope='col']", text: "Question"
      expect(rendered).to have_selector "th[scope='col']", text: "Your Answer"
      expect(rendered).to have_selector "th[scope='col']", text: "Result"
      expect(rendered).to have_selector "td", text: question_answer.question.content
      expect(rendered).to have_selector "td", text: question_answer.answer
      expect(rendered).to have_selector "td", text: question_answer.is_correct

      expect(rendered).to have_selector "a.btn.btn-success[href='#{quiz_path(category)}']"
    end
  end
end
