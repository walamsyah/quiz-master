require 'rails_helper'

RSpec.describe "dashboard/categories/new.html.slim", type: :view do
  it "will render partial form and header" do
    category = build :category
    assign :category, category
    render

    expect(rendered).to render_template partial: "shared/_form_header", locals:  { title: "Create Quiz", backlink: dashboard_categories_path }
    expect(rendered).to render_template partial: "_form", locals: { category: category }
  end
end
