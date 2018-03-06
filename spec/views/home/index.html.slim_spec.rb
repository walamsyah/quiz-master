require 'rails_helper'

RSpec.describe "home/index.html.slim", type: :view do
  context "default render" do
    it "render welcome message" do
      render
      expect(rendered).to have_selector ".jumbotron.p-3.p-md-5.text-white.rounded.bg-dark"
      expect(rendered).to have_selector "h1.display-4.font-italic", text: "Welcome to Quiz Master"
      expect(rendered).to have_selector "p.lead.my-3", text: "You can play a variety of educational and entertaining quizzes just here"
    end
  end
end
