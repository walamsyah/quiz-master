require 'rails_helper'

RSpec.describe "dashboard/index.html.slim", type: :view do
  it "render welcome message" do
    render
    expect(rendered).to have_selector "h1.h2", text: "Welcome to Quiz Master"
    expect(rendered).to have_selector "h4 a[href='#{dashboard_categories_path}']", text: "Manage Categories"
    expect(rendered).to have_selector "h4 a[href='#{dashboard_questions_path}']", text: "Manage Questions"
  end
end
