require "rails_helper"

RSpec.feature "Manage Dashboard Users", :type => :feature do
  let!(:admin) { create :user, role: 'admin' }
  let!(:user_name) { "Member Name" }
  let!(:user) { create :user, role: 'member', name: user_name }

  before do
    login_as admin
    visit dashboard_path
    click_link "Users"
  end

  context "Quiz Users CRUD" do
    it "user index page" do
      expect(current_path).to eq dashboard_users_path
      expect(page).to have_content "Users"
      expect(page).to have_css "td", text: user.name
      expect(page).to have_css "td", text: user.email
      expect(page).to have_css "td", text: user.role
    end

    it "can edit user" do
      find(".edit-user-#{user.id}").click
      expect(current_path).to eq edit_dashboard_user_path(user)

      select('Admin', from: 'user_role')
      click_button "Update User"

      expect(current_path).to eq dashboard_users_path
      expect(page).to have_content('User was successfully updated.')
    end

    it "can delete user" do
      expect(page).to have_css "td", text: user.name
      find(".delete-user-#{user.id}").click
      expect(current_path).to eq dashboard_users_path
      expect(page).to have_content('User was successfully deleted.')
      expect(page).not_to have_css "td", text: user_name
    end
  end
end
