require "rails_helper"

RSpec.feature "Sign Up", :type => :feature do
  it "will doing sign in then sign out process" do
    visit root_path
    click_link "Sign In"

    expect(current_path).to eq new_user_session_path

    click_link "Sign up"

    expect(current_path).to eq new_user_registration_path

    fill_in "user_name", with: "Wisnu Alamsyah"
    fill_in "user_email", with: "wisnu@gmail.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign Up"

    expect(current_path).to eq root_path
    expect(page).to have_content "Welcome! You have signed up successfully."
  end
end
