require "rails_helper"

RSpec.feature "Search Quizzes", :type => :feature do
  let!(:category) { create :category, name: "All About Jakarta" }

  it "will show search result by keyword" do
    visit root_path

    fill_in "q", with: "jakarta"
    find(".search-button", visible: false).click

    expect(current_path).to eq search_path
    expect(page).to have_content "Search"
    expect(page).to have_content "Found 1 result for jakarta"
    expect(page).to have_content "All About Jakarta"
  end
end
