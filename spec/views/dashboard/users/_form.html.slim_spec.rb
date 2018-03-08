require 'rails_helper'

RSpec.describe "dashboard/users/_form.html.slim", type: :view do
  context "edit user" do
    it "will render form input and partial form_errors" do
      user = create :user
      render "dashboard/users/form", user: user

      expect(rendered).to render_template partial: "shared/_form_errors", locals: { data: user }
      expect(rendered).to have_selector "form#edit_user_#{user.id}"
      expect(rendered).to have_selector "select#user_role"
    end
  end
end
