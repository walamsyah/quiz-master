require 'rails_helper'

RSpec.describe "devise/registrations/edit.html.slim", type: :view do
  let!(:user) { create :user }

  before do
    assign :resource, user
  end

  it "will render edit profile form" do
    render

    expect(rendered).to have_selector "h1.text-center", text: "Edit User"
    expect(rendered).to have_selector "form#edit_user"
    expect(rendered).to have_selector "input#user_name"
    expect(rendered).to have_selector "input#user_email"
    expect(rendered).to have_selector "input#user_current_password[type='password']"
    expect(rendered).to have_selector "input#user_password[type='password']"
    expect(rendered).to have_selector "input#user_password_confirmation[type='password']"
    expect(rendered).to have_selector "button.btn.btn-lg.btn-primary.btn-block[type='submit']", text: "Update"
  end
end
