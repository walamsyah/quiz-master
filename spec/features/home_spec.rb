require "rails_helper"

RSpec.feature "Root Path", :type => :feature do
  let!(:category) { create :category }

  before do
    visit root_path
  end

  context "Latest Quiz" do
    it "category index page" do
      expect(page).to have_content "Latest Quizzes"
      expect(page).to have_content category.name
      expect(page).to have_content "#{category.total_questions} questions"
    end
  end
end
