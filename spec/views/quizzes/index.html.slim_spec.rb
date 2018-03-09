require 'rails_helper'

RSpec.describe "quizzes/index.html.slim", type: :view do
  let!(:category) { create :category }

  it "will render partial template category_thumbnails" do
    assign :categories, [category]
    render

    expect(rendered).to have_selector "h1", text: "Latest Quiz"
    expect(rendered).to render_template partial: "shared/_category_thumbnails", locals: { categories: [category] }
  end
end
