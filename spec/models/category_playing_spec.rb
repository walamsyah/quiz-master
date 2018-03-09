require 'rails_helper'

RSpec.describe CategoryPlaying, type: :model do
  it "has columns" do
    should have_db_column(:category_token).of_type(:string)
    should have_db_column(:category_id).of_type(:integer)
    should have_db_column(:user_id).of_type(:integer)
    should have_db_column(:total_questions).of_type(:integer)
    should have_db_column(:total_corrects).of_type(:integer)
    should have_db_column(:point).of_type(:decimal)
  end

  it "has validation" do
    is_expected.to validate_presence_of :total_questions
    is_expected.to validate_presence_of :total_corrects
    is_expected.to validate_presence_of :point
    is_expected.to validate_presence_of :category_token
  end

  it "has associations" do
    is_expected.to belong_to :category
    is_expected.to belong_to :user
  end
end
