require "rails_helper"

RSpec.describe "Dashboard Questions CRUD", type: :routing do
  it "will have routing" do
    expect(get dashboard_questions_path).to route_to controller: "dashboard/questions", action: "index"
    expect(get new_dashboard_question_path).to route_to controller: "dashboard/questions", action: "new"
    expect(post dashboard_questions_path).to route_to controller: "dashboard/questions", action: "create"
    expect(get edit_dashboard_question_path(1)).to route_to controller: "dashboard/questions", action: "edit", id: "1"
    expect(patch dashboard_question_path(1)).to route_to controller: "dashboard/questions", action: "update", id: "1"
    expect(delete dashboard_question_path(1)).to route_to controller: "dashboard/questions", action: "destroy", id: "1"
  end
end
