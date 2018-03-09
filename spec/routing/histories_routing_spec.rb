require "rails_helper"

RSpec.describe "Histories Routing", type: :routing do
  it "will have routing" do
    expect(get histories_path).to route_to controller: "histories", action: "index"
  end
end
