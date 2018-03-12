require 'rails_helper'

RSpec.describe "results/show.html.slim", type: :view do
  let!(:category) { create :category }

  context "results present" do
    it "will show quiz results list" do
      category = create :category
      history = create :question_answer, category: category
      assign :results, [history]
      render

      expect(rendered).to have_selector "h1", text: "Quiz Result"
      expect(rendered).to have_selector "h1.display-4.text-center", text: category.name
      expect(rendered).to have_selector "img.img-fluid[src='#{category.image_url(:big)}']"
      expect(rendered).to render_template partial: "shared/_result_list", locals: { results: [history] }
    end
  end

  context "results not present" do
    it "will not show quiz results list" do
      assign :results, []
      render

      expect(rendered).to have_selector "h1", text: "Quiz Result"
      expect(rendered).to have_content "We could not find what you were looking for."
    end
  end
end
