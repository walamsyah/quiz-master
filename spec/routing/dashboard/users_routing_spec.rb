require "rails_helper"

RSpec.describe "Dashboard Users CRUD", type: :routing do
  it "will have routing" do
    expect(get dashboard_users_path).to route_to controller: "dashboard/users", action: "index"
    expect(get edit_dashboard_user_path(1)).to route_to controller: "dashboard/users", action: "edit", id: "1"
    expect(patch dashboard_user_path(1)).to route_to controller: "dashboard/users", action: "update", id: "1"
    expect(delete dashboard_user_path(1)).to route_to controller: "dashboard/users", action: "destroy", id: "1"
  end
end
