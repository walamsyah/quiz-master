require "rails_helper"

RSpec.feature "Manage Dashboard Categories", :type => :feature do
  let!(:category) { create :category }

  before do
    visit dashboard_path
    click_link "Categories"
  end

  context "Quiz categories CRUD" do
    it "category index page" do
      expect(current_path).to eq dashboard_categories_path
      expect(page).to have_content "Quiz Categories"
      expect(page).to have_css "td", text: category.name
    end

    it "can create category" do
      click_link "Create"
      expect(current_path).to eq new_dashboard_category_path

      fill_in "category_name", with: "All About Jakarta"
      fill_in "category_description", with: "Interesting things about Jakarta will be fun"
      check "category_published"
      click_button "Create Category"
      
      expect(current_path).to eq dashboard_categories_path
      expect(page).to have_content('Quiz category was successfully created.')
      expect(page).to have_css "td", text: "All About Jakarta"
      expect(page).to have_css "td", text: "true"
    end

    it "can edit category" do
      click_link "Edit"
      expect(current_path).to eq edit_dashboard_category_path(category)

      fill_in "category_name", with: "All About Jakarta"
      fill_in "category_description", with: "Interesting things about Jakarta will be fun"
      check "category_published"
      click_button "Update Category"
      
      expect(current_path).to eq dashboard_categories_path
      expect(page).to have_content('Quiz category was successfully updated.')
      expect(page).to have_css "td", text: "All About Jakarta"
      expect(page).to have_css "td", text: "true"    
    end

    it "can delete category" do
      expect(page).to have_css "td", text: category.name
      click_link "Delete"
      expect(current_path).to eq dashboard_categories_path
      expect(page).to have_content('Quiz category was successfully deleted.')
      expect(page).not_to have_css "td", text: category.name
    end
  end
end
