require "rails_helper"

RSpec.feature "Reults Playing Quiz", :type => :feature do
  let!(:user) { create :user }
  let!(:category) { create :category }
  let!(:token) { '123456' }
  let!(:question_answer) { create :question_answer, category: category, user: user, category_token: token }
  let!(:history) { create :category_playing, user: user, category: category, category_token: token }

  before do
    login_as user
    visit root_path
  end

  it "will show history list" do
    click_link user.name
    click_link "Playing History"

    expect(current_path).to eq histories_path
    expect(page).to have_content "History of Playing Quizzes"
    
    click_link "Result"

    expect(current_path).to eq result_path(token)
    expect(page).to have_content "Quiz Result"
    expect(page).to have_content category.name
    expect(page).to have_content question_answer.question.content
  end
end
