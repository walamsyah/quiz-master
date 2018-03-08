require 'rails_helper'

RSpec.describe "dashboard/users/edit.html.slim", type: :view do
  it "will render partial form and header" do
    user = create :user
    assign :user, user
    render

    expect(rendered).to render_template partial: "shared/_form_header", locals:  { title: "Edit User", backlink: dashboard_users_path }
    expect(rendered).to render_template partial: "_form", locals: { user: user }
  end
end
