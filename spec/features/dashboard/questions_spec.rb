require "rails_helper"

RSpec.feature "Manage Dashboard Questions", :type => :feature do
  let!(:admin) { create :user, role: 'admin' }
  let!(:category) { create :category }
  let!(:question) { create :question, category: category }

  before do
    login_as admin
    visit dashboard_path
    click_link "Questions"
  end

  context "Quiz Questions CRUD" do
    it "question index page" do
      expect(current_path).to eq dashboard_questions_path
      expect(page).to have_content "Quiz Questions"
      expect(page).to have_css "td", text: question.category.name
      expect(page).to have_css "td", text: question.content
      expect(page).to have_css "td", text: question.answer
    end

    it "can create question" do
      click_link "Create"
      expect(current_path).to eq new_dashboard_question_path

      select category.name, from: "question_category_id"
      fill_in "question_answer", with: "18"
      fill_in "question_content", with: "How old are you?"
      check "question_published"
      click_button "Create Question"
      
      expect(current_path).to eq dashboard_questions_path
      expect(page).to have_content('Quiz question was successfully created.')
      expect(page).to have_css "td", text: "How old are you?"
      expect(page).to have_css "td", text: "18"
      expect(page).to have_css "td", text: "true"
    end

    it "can edit question" do
      click_link "Edit"
      expect(current_path).to eq edit_dashboard_question_path(question)

      fill_in "question_content", with: "Can we disturb on library?"
      fill_in "question_answer", with: "No"
      check "question_published"
      click_button "Update Question"

      expect(current_path).to eq dashboard_questions_path
      expect(page).to have_content('Quiz question was successfully updated.')
      expect(page).to have_css "td", text: "Can we disturb on library?"
      expect(page).to have_css "td", text: "No"
      expect(page).to have_css "td", text: "true"
    end

    it "can delete question" do
      expect(page).to have_css "td", text: question.category.name
      expect(page).to have_css "td", text: question.content
      expect(page).to have_css "td", text: question.answer
      click_link "Delete"
      expect(current_path).to eq dashboard_questions_path
      expect(page).to have_content('Quiz question was successfully deleted.')
      expect(page).not_to have_css "td", text: question.category.name
      expect(page).not_to have_css "td", text: question.content
      expect(page).not_to have_css "td", text: question.answer
    end
  end
end
