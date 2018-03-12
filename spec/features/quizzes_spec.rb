require "rails_helper"

RSpec.feature "Play with quiz", :type => :feature do
  let!(:user) { create :user }
  let!(:category) { create :category }
  let!(:question) { create :question, category: category }

  before do
    login_as user
    visit root_path
  end

  context "playing quiz from root page" do
    it "will play quiz" do
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
      expect(page).to have_css "td i.icon__false"
    end
  end

  context "view quiz list" do
    it "will show last quizzes" do
      click_link "Quizzes"

      expect(current_path).to eq quizzes_path
      expect(page).to have_content "Latest Quiz"
      expect(page).to have_content category.name
    end
  end
end
