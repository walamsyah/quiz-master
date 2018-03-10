require 'rails_helper'

RSpec.describe "dashboard/categories/edit.html.slim", type: :view do
  it "will render partial form and header" do
    category = create :category
    assign :category, category
    render

    expect(rendered).to render_template partial: "shared/_form_header", locals:  { title: "Edit Quiz", backlink: dashboard_categories_path }
    expect(rendered).to render_template partial: "_form", locals: { category: category }
  end
end
