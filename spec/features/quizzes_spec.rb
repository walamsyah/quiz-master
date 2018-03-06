require "rails_helper"

RSpec.feature "Play with quiz", :type => :feature do
  let!(:category) { create :category }

  before do
    visit root_path
  end

  it "category index page" do
    click_link "Play Now"
    expect(current_path).to eq quiz_path(category)
    expect(page).to have_content category.name
    expect(page).to have_content category.description
    expect(page).to have_content "LET'S PLAY NOW"
  end
end
