require "rails_helper"

RSpec.describe "Dashboard Root", type: :routing do
  it "will have routing" do
    expect(get dashboard_path).to route_to controller: "dashboard", action: "index"
  end
end
