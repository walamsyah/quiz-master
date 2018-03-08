require "rails_helper"

RSpec.feature "Sign In and Sign Out", :type => :feature do
  let!(:user) { create :user, password: "password" }

  it "will doing sign in then sign out process" do
    visit root_path
    click_link "Sign In"

    expect(current_path).to eq new_user_session_path

    fill_in "user_email", with: user.email
    fill_in "user_password", with: "password"
    click_button "Sign In"

    expect(current_path).to eq root_path
    expect(page).to have_content "Signed in successfully."

    click_link user.name
    click_link "Sign Out"

    expect(current_path).to eq root_path
    expect(page).to have_content "Signed out successfully."  
  end
end
