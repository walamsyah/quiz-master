require "rails_helper"

RSpec.describe "Questions Routes", type: :routing do
  it "will have routing" do
    expect(post start_quiz_questions_path(1)).to route_to controller: "questions", action: "start", quiz_id: "1"
    expect(post quiz_questions_path(1)).to route_to controller: "questions", action: "create", quiz_id: "1"
  end
end
