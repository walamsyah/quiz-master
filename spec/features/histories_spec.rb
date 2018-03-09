require "rails_helper"

RSpec.feature "Playing Quiz Histories", :type => :feature do
  let!(:user) { create :user }
  let!(:history) { create :category_playing, user: user }

  before do
    login_as user
    visit root_path
  end

  it "will show history list" do
    click_link user.name
    click_link "Playing History"

    expect(current_path).to eq histories_path
    expect(page).to have_content "History of Playing Quizzes"
    expect(page).to have_content history.category.name
  end
end
