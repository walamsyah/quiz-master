require "rails_helper"

RSpec.describe "Quizzes Routes", type: :routing do
  it "will have routing" do
    expect(get quiz_path(1)).to route_to controller: "quizzes", action: "show", id: "1"
  end
end
