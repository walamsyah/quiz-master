require "rails_helper"

RSpec.feature "Root Path", :type => :feature do
  let!(:category) { create :category }

  before do
    visit root_path
  end

  context "Latest Quiz" do
    it "category index page" do
      expect(page).to have_css "h3.font-italic.border-bottom", text: "Latest Quiz"
      expect(page).to have_css "p.card-text", text: category.name
    end
  end
end
