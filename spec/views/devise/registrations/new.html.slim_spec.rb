require 'rails_helper'

RSpec.describe "devise/registrations/new.html.slim", type: :view do
  it "will render registration form" do
    render

    expect(rendered).to have_selector "h1.text-center", text: "Sign Up"
    expect(rendered).to have_selector "form#new_user"
    expect(rendered).to have_selector "input#user_name"
    expect(rendered).to have_selector "input#user_email"
    expect(rendered).to have_selector "input#user_password[type='password']"
    expect(rendered).to have_selector "input#user_password_confirmation[type='password']"
    expect(rendered).to have_selector "button.btn.btn-lg.btn-primary.btn-block[type='submit']", text: "Sign Up"

    expect(rendered).to render_template "devise/shared/_links"   
  end
end
