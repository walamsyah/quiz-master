require "rails_helper"

RSpec.feature "Popular Quizzes", :type => :feature do
  let!(:user) { create :user }
  let!(:playing) { create :category_playing }

  it "will show last quizzes" do
    visit root_path
    click_link "Popular"

    expect(current_path).to eq popular_path
    expect(page).to have_content "Popular Quizzes"
    expect(page).to have_content playing.category.name
  end
end
