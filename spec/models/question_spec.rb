require 'rails_helper'

RSpec.describe Question, type: :model do
  it "has columns" do
    should have_db_column(:content).of_type(:text)
    should have_db_column(:answer).of_type(:string)
    should have_db_column(:image).of_type(:string)
    should have_db_column(:published).of_type(:boolean)
    should have_db_column(:position).of_type(:integer)
  end

  it "has validation" do
    is_expected.to validate_presence_of :content
    is_expected.to validate_presence_of :answer
    is_expected.to validate_presence_of :position
  end

  it "has associations" do
    is_expected.to belong_to :category
  end
end
