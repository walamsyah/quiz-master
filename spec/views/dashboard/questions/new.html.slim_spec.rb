require 'rails_helper'

RSpec.describe "dashboard/questions/new.html.slim", type: :view do
  it "will render partial form and header" do
    question = build :question
    assign :question, question
    render

    expect(rendered).to render_template partial: "shared/_form_header", locals:  { title: "Create Quiz Question", backlink: dashboard_questions_path }
    expect(rendered).to render_template partial: "_form", locals: { question: question }
  end
end
