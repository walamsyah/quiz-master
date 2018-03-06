require "rails_helper"

RSpec.describe "Home Root", type: :routing do
  it "will have routing" do
    expect(get "/").to route_to controller: "home", action: "index"
  end
end
