require 'rails_helper'

RSpec.describe "dashboard/questions/index.html.slim", type: :view do
  let!(:question) { create :question }

  it "render table list when @questions present" do
    assign :questions, [question]
    render

    expect(rendered).to have_content "Quiz Questions"
    expect(rendered).to have_selector "a.btn.btn-sm.btn-outline-secondary[href='#{new_dashboard_question_path}']", text: "Create"

    expect(rendered).to have_selector "table.table.table-striped"
    expect(rendered).to have_selector "th[scope='col']", text: "Category"
    expect(rendered).to have_selector "th[scope='col']", text: "Content"
    expect(rendered).to have_selector "th[scope='col']", text: "Answer"
    expect(rendered).to have_selector "th[scope='col']", text: "Position"
    expect(rendered).to have_selector "th[scope='col']", text: "Published"
    expect(rendered).to have_selector 'td', text: question.category.name
    expect(rendered).to have_selector 'td', text: question.content
    expect(rendered).to have_selector 'td', text: question.answer
    expect(rendered).to have_selector 'td', text: question.position
    expect(rendered).to have_selector 'td', text: question.published
    expect(rendered).to have_selector "td a.btn.btn-warning.btn-sm[href='#{edit_dashboard_question_path(question)}']", text: "Edit"
    expect(rendered).to have_selector "td a.btn.btn-danger.btn-sm[href='#{dashboard_question_path(question)}']", text: "Delete"
  end
  
  it "will not render table list when @questions not present" do
    assign :questions, []
    render

    expect(rendered).to have_content "Quiz Questions"
    expect(rendered).to have_selector "a.btn.btn-sm.btn-outline-secondary[href='#{new_dashboard_question_path}']", text: "Create"
    expect(rendered).not_to have_selector "table.table.table-striped"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Category"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Content"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Answer"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Position"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Published"
  end
end
