require "rails_helper"

RSpec.describe "Results Routes", type: :routing do
  it "will have routing" do
    expect(get result_path(1)).to route_to controller: "results", action: "show", id: "1"
  end
end
