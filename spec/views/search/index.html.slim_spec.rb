require 'rails_helper'

RSpec.describe "search/index.html.slim", type: :view do
  let!(:category) { create :category }

  context "have result" do
    it "will show result count and render partial template category_thumbnails" do
      stub_template 'shared/_pagination' => ''
      assign :categories, Kaminari.paginate_array([category]).page(1)
      assign :query, "jakarta"
      
      render

      expect(rendered).to have_selector "h1", text: "Search"
      expect(rendered).to have_content "Found 1 result for jakarta"
      expect(rendered).to render_template partial: "shared/_category_thumbnails", locals: { categories: [category] }
    end
  end

  context "not have result" do
    it "will not show result count but render partial template category_thumbnails" do
      stub_template 'shared/_pagination' => ''
      assign :categories, []
      assign :populars, [category]
      
      render

      expect(rendered).to have_selector "h1", text: "Search"
      expect(rendered).to have_content "We could not find what you were looking for. Maybe you are interested to try the quizzes below."
      expect(rendered).to render_template partial: "shared/_category_thumbnails", locals: { categories: [category] }
    end
  end
end
