require 'rails_helper'

RSpec.describe "questions/start.html.slim", type: :view do
  it "will show question form" do
    category = create :category
    question = create :question, category: category

    allow(view).to receive(:params).and_return({ category_token: '123456' })

    assign :category, category
    assign :questions, [question]
    assign :next_page, '2'

    render

    expect(rendered).to have_selector "form#question-form[action='#{quiz_questions_path(category)}'][method='post'][data-remote='true']"
    expect(rendered).to have_selector "input[type='hidden'][name='category_token'][value='123456']", visible: false
    expect(rendered).to have_selector "input[type='hidden'][name='question_id'][value='#{question.id}']", visible: false
    expect(rendered).to have_selector "input[type='hidden'][name='page'][value='2']", visible: false
    expect(rendered).to have_content question.content
    expect(rendered).to have_selector "input#answer.form-control[placeholder='type your answer here'][type='text'][name='answer'][required='required']"
    expect(rendered).to have_selector "button.btn.btn-primary[type='submit']", text: "Submit"
  end
end
