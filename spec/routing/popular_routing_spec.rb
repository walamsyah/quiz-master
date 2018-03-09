require "rails_helper"

RSpec.describe "Popular Routing", type: :routing do
  it "will have routing" do
    expect(get popular_path).to route_to controller: "popular", action: "index"
  end
end
