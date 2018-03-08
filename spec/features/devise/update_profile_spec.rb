require "rails_helper"

RSpec.feature "Sign Up", :type => :feature do
  let!(:user) { create :user, password: "password" }
  
  it "will doing sign in then sign out process" do
    login_as user
    visit root_path

    click_link user.name
    click_link "Profile"

    expect(current_path).to eq edit_user_registration_path

    fill_in "user_name", with: "Wisnu Alamsyah"
    fill_in "user_email", with: "wisnu@gmail.com"
    fill_in "user_current_password", with: "password"
    click_button "Update"

    expect(current_path).to eq root_path
    expect(page).to have_content "Your account has been updated successfully."
  end
end
