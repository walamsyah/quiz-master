require 'rails_helper'

RSpec.describe "shared/_result_list.html.slim", type: :view do
  
  it "will render table list, share button and play again button" do
    category = create :category
    result = create :question_answer, category: category

    render "shared/result_list", results: [result]

    expect(rendered).to have_selector "th[scope='col']", text: "Question"
    expect(rendered).to have_selector "th[scope='col']", text: "Your Answer"
    expect(rendered).to have_selector "th[scope='col']", text: "Result"
    expect(rendered).to have_selector "td", text: result.question.content
    expect(rendered).to have_selector "td.text-center", text: result.answer
    expect(rendered).to have_selector "td.text-center", text: result.is_correct

    expect(rendered).to have_selector "a.btn.btn-sm.btn-sosmed.btn-fb[href='https://www.facebook.com/sharer/sharer.php?u=#{result_url(result.category_token)}']", text: "Share on Facebook"
    expect(rendered).to have_selector "a.btn.btn-sm.btn-sosmed.btn-tw[href='https://twitter.com/home?status=#{result_url(result.category_token)}']", text: "Tweet on Twitter"
    expect(rendered).to have_selector "a.btn.btn-success[href='#{quiz_path(category)}']", text: "PLAY AGAIN"
   
  end
end
