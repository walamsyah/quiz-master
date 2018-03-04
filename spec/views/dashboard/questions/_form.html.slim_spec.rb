require 'rails_helper'

RSpec.describe "dashboard/questions/_form.html.slim", type: :view do
  context "create new question" do
    it "will render form input and partial form_errors" do
      question = build :question
      render "dashboard/questions/form", question: question

      expect(rendered).to render_template partial: "shared/_form_errors", locals: { data: question }
      expect(rendered).to have_selector "form#new_question"
      expect(rendered).to have_selector "select#question_category_id[required=required]"
      expect(rendered).to have_selector "textarea#question_content"
      expect(rendered).to have_selector "input#question_answer[required=required]"
      expect(rendered).to have_selector "input#question_position[required=required][type=number]"
      expect(rendered).to have_selector "input#question_published[type=checkbox]"
      expect(rendered).to have_selector "input[type=submit][value='Create Question']"
    end
  end

  context "edit question" do
    it "will render form input and partial form_errors" do
      question = create :question
      render "dashboard/questions/form", question: question

      expect(rendered).to render_template partial: "shared/_form_errors", locals: { data: question }
      expect(rendered).to have_selector "form#edit_question_#{question.id}"
      expect(rendered).to have_selector "input[type=submit][value='Update Question']"
      expect(rendered).to have_selector "select#question_category_id[required=required]"
      expect(rendered).to have_selector "textarea#question_content"
      expect(rendered).to have_selector "input#question_answer[required=required]"
      expect(rendered).to have_selector "input#question_position[required=required][type=number]"
      expect(rendered).to have_selector "input#question_published[type=checkbox]"
    end
  end
end
