require 'rails_helper'

RSpec.describe "dashboard/categories/index.html.slim", type: :view do
  let!(:category) { create :category }

  before do
    stub_template 'shared/_pagination' => ''
  end

  it "render table list when @categories present" do
    assign :categories, [category]
    render

    expect(rendered).to have_content "Quizzes"
    expect(rendered).to have_selector "a.btn.btn-sm.btn-outline-secondary[href='#{new_dashboard_category_path}']", text: "Create"

    expect(rendered).to have_selector "table.table.table-hover.table-bordered"
    expect(rendered).to have_selector "th[scope='col']", text: "Name"
    expect(rendered).to have_selector "th[scope='col']", text: "Published"
    expect(rendered).to have_selector 'td', text: category.name
    expect(rendered).to have_css "td i.icon__true"
    expect(rendered).to have_selector "td a.btn.btn-warning.btn-sm[href='#{edit_dashboard_category_path(category)}']", text: "Edit"
    expect(rendered).to have_selector "td a.btn.btn-danger.btn-sm[href='#{dashboard_category_path(category)}']", text: "Delete"
  end
  
  it "will not render table list when @categories not present" do
    assign :categories, []
    render

    expect(rendered).to have_content "Quizzes"
    expect(rendered).to have_selector "a.btn.btn-sm.btn-outline-secondary[href='#{new_dashboard_category_path}']", text: "Create"
    expect(rendered).not_to have_selector "table.table.table-hover.table-bordered"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Name"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Published"
  end
end
