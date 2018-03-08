require "rails_helper"

RSpec.feature "Play with quiz", :type => :feature do
  let!(:user) { create :user }
  let!(:category) { create :category }
  let!(:question) { create :question, category: category }

  before do
    login_as user
    visit root_path
  end

  it "category index page" do
    click_link "Play Now"
    expect(current_path).to eq quiz_path(category)
    expect(page).to have_content category.name
    expect(page).to have_content category.description

    click_button "LET'S PLAY NOW"
    sleep 1

    fill_in "answer", with: "piyama"
    expect(page).to have_content question.content

    click_button "Submit"
    sleep 1

    expect(page).to have_content question.content
    expect(page).to have_content "piyama"
    expect(page).to have_content "FALSE"
  end
end
