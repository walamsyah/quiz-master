require "rails_helper"

RSpec.describe "Dashboard Categories CRUD", type: :routing do
  it "will have routing" do
    expect(get dashboard_categories_path).to route_to controller: "dashboard/categories", action: "index"
    expect(get new_dashboard_category_path).to route_to controller: "dashboard/categories", action: "new"
    expect(post dashboard_categories_path).to route_to controller: "dashboard/categories", action: "create"
    expect(get edit_dashboard_category_path(1)).to route_to controller: "dashboard/categories", action: "edit", id: "1"
    expect(patch dashboard_category_path(1)).to route_to controller: "dashboard/categories", action: "update", id: "1"
    expect(delete dashboard_category_path(1)).to route_to controller: "dashboard/categories", action: "destroy", id: "1"
  end
end
