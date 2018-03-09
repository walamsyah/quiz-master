require 'rails_helper'

RSpec.describe "dashboard/users/index.html.slim", type: :view do
  let!(:user) { create :user }

  it "render table list when @users present" do
    assign :users, [user]
    render

    expect(rendered).to have_content "Users"
    expect(rendered).to have_selector "button[data-toggle='dropdown']", text: "Role"

    expect(rendered).to have_selector "table.table.table-hover.table-bordered"
    expect(rendered).to have_selector "th[scope='col']", text: "Name"
    expect(rendered).to have_selector "th[scope='col']", text: "Email"
    expect(rendered).to have_selector "th[scope='col']", text: "Role"
    expect(rendered).to have_selector 'td', text: user.name
    expect(rendered).to have_selector 'td', text: user.email
    expect(rendered).to have_selector 'td', text: user.role
    expect(rendered).to have_selector "td a.btn.btn-warning.btn-sm[href='#{edit_dashboard_user_path(user)}']", text: "Edit"
    expect(rendered).to have_selector "td a.btn.btn-danger.btn-sm[href='#{dashboard_user_path(user)}']", text: "Delete"
  end
  
  it "not render table list when @users not present" do
    assign :users, []
    render

    expect(rendered).to have_content "Users"
    expect(rendered).to have_selector "button[data-toggle='dropdown']", text: "Role"

    expect(rendered).not_to have_selector "table.table.table-hover.table-bordered"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Name"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Email"
    expect(rendered).not_to have_selector "th[scope='col']", text: "Role"
  end
end
