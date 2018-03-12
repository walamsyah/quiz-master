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
    end
  end

  context "@results is present" do
    it "will show results list" do
      question_answer = create :question_answer, category: category

      assign :category, category
      assign :results, [question_answer]

      render

      expect(rendered).to render_template partial: "shared/_result_list", locals: { results: [question_answer] }
    end
  end
end
