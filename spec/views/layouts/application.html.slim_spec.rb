require 'rails_helper'

RSpec.describe "layouts/application.html.slim", type: :view do
  it "render welcome message" do
    render

    expect(rendered).to have_selector "a.blog-header-logo.text-dark[href='#{root_path}']", text: "Quiz Master"
    expect(rendered).to have_selector "a.p-2.text-muted[href='#{root_path}']", text: "Home"
  end
end
