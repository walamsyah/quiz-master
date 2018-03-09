require "rails_helper"

RSpec.feature "Root Path", :type => :feature do
  let!(:category) { create :category }

  context "Popular Quizzes" do
    let!(:popular)  { create :category_playing, category: category }

    it "will show categories" do
      visit root_path

      expect(page).to have_content "Popular Quizzes"
      expect(page).to have_content category.name
      expect(page).to have_content "#{category.total_questions} questions"
      expect(page).to have_content "1 plays"
    end
  end

  context "Latest Quizzes" do
    it "will show categories" do
      visit root_path

      expect(page).to have_content "Latest Quizzes"
      expect(page).to have_content category.name
      expect(page).to have_content "#{category.total_questions} questions"
    end
  end
end
