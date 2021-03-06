require 'rails_helper'

RSpec.describe "users/sessions/new.html.slim", type: :view do
  it "will render login form" do
    render

    expect(rendered).to have_selector "h1.text-center", text: "Sign In"
    expect(rendered).to have_selector "form#new_user"
    expect(rendered).to have_selector "input#user_email"
    expect(rendered).to have_selector "input#user_password[type='password']"
    expect(rendered).to have_selector "input#user_remember_me[type='checkbox']"
    expect(rendered).to have_selector "button.btn.btn-lg.btn-primary.btn-block[type='submit']", text: "Sign In"
  end
end
