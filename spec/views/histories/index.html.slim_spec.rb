require 'rails_helper'

RSpec.describe "histories/index.html.slim", type: :view do
  context "history not present" do
    it "will render 'PLAY NOW' button" do
      assign :histories, []
      render

      expect(rendered).to have_selector "h1", text: "History of Playing Quizzes"
      expect(rendered).to have_selector "h3.text-center", text: "It looks like you've never played quiz"
      expect(rendered).to have_selector "a.btn.btn-primary[href='#{quizzes_path}']", text: "PLAY NOW"
    end
  end

  context "history present" do
    it "will render quiz history lists" do
      stub_template 'shared/_pagination' => ''
      history = create :category_playing
      assign :histories, [history]
      render

      expect(rendered).to have_selector "h1", text: "History of Playing Quizzes"
      expect(rendered).to have_selector "th.text-center[scope='col']", text: "Date"
      expect(rendered).to have_selector "th[scope='col']", text: "Quiz"
      expect(rendered).to have_selector "th.text-center[scope='col']", text: "Question"
      expect(rendered).to have_selector "th.text-center[scope='col']", text: "Correct"
      expect(rendered).to have_selector "th.text-center[scope='col']", text: "Point"

      expect(rendered).to have_selector "td.text-center", text: history.created_at.strftime("%Y-%m-%d %H:%M")
      expect(rendered).to have_selector "td", text: history.category.name
      expect(rendered).to have_selector "td.text-center", text: history.total_questions
      expect(rendered).to have_selector "td.text-center", text: history.total_corrects
      expect(rendered).to have_selector "td.text-center", text: history.point * 100
      expect(rendered).to have_selector "a.btn.btn-sm.btn-primary[href='#{result_path(history.category_token)}']", text: "Result"
      expect(rendered).to have_selector "a.btn.btn-sm.btn-success[href='#{quiz_path(history.category)}']", text: "Play Again"
    end
  end
end
