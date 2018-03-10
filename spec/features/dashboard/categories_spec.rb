require "rails_helper"

RSpec.feature "Manage Dashboard Quizzes", :type => :feature do
  let!(:admin) { create :user, role: 'admin' }
  let!(:category) { create :category }

  before do
    login_as admin
    visit dashboard_path
    click_link "Quizzes"
  end

  context "Quiz CRUD" do
    it "category index page" do
      expect(current_path).to eq dashboard_categories_path
      expect(page).to have_content "Quizzes"
      expect(page).to have_css "td", text: category.name
    end

    it "can create quiz" do
      click_link "Create"
      expect(current_path).to eq new_dashboard_category_path

      fill_in "category_name", with: "All About Jakarta"
      fill_in "category_description", with: "Interesting things about Jakarta will be fun"
      find("#category_image", visible: false).set "#{Rails.root}/spec/fixtures/image.jpg"
      check "category_published"
      click_button "Create Quiz"
      
      expect(current_path).to eq dashboard_categories_path
      expect(page).to have_content('Quiz was successfully created.')
      expect(page).to have_css "td", text: "All About Jakarta"
      expect(page).to have_css "td", text: "true"
    end

    it "can edit quiz" do
      click_link "Edit"
      expect(current_path).to eq edit_dashboard_category_path(category)

      fill_in "category_name", with: "All About Jakarta"
      fill_in "category_description", with: "Interesting things about Jakarta will be fun"
      check "category_published"
      click_button "Update Quiz"
      
      expect(current_path).to eq dashboard_categories_path
      expect(page).to have_content('Quiz was successfully updated.')
      expect(page).to have_css "td", text: "All About Jakarta"
      expect(page).to have_css "td", text: "true"    
    end

    it "can delete quiz" do
      expect(page).to have_css "td", text: category.name
      click_link "Delete"
      expect(current_path).to eq dashboard_categories_path
      expect(page).to have_content('Quiz was successfully deleted.')
      expect(page).not_to have_css "td", text: category.name
    end
  end
end
