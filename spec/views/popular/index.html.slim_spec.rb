require 'rails_helper'

RSpec.describe "popular/index.html.slim", type: :view do
  let!(:category) { create :category }

  it "will render partial template category_thumbnails" do
    stub_template 'shared/_pagination' => ''
    assign :categories, [category]
    render

    expect(rendered).to have_selector "h1", text: "Popular Quizzes"
    expect(rendered).to render_template partial: "shared/_category_thumbnails", locals: { categories: [category] }
  end
end
