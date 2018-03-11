require "rails_helper"

RSpec.describe "Search Routing", type: :routing do
  it "will have routing" do
    expect(get search_path).to route_to controller: "search", action: "index"
  end
end
