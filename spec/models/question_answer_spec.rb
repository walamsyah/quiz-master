require 'rails_helper'

RSpec.describe QuestionAnswer, type: :model do
   it "has columns" do
    should have_db_column(:category_id).of_type(:integer)
    should have_db_column(:question_id).of_type(:integer)
    should have_db_column(:answer).of_type(:string)
    should have_db_column(:category_token).of_type(:string)
    should have_db_column(:is_correct).of_type(:boolean)
  end

  it "has validation" do
    is_expected.to validate_presence_of :answer
    is_expected.to validate_presence_of :category_token
  end

  it "has associations" do
    is_expected.to belong_to :category
    is_expected.to belong_to :question
    is_expected.to belong_to :user
  end
end
