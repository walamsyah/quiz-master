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

  describe '.published' do
    it 'show published question' do
      cat1 = create :question, published: false
      cat2 = create :question, published: true

      expect(Question.published.count).to eq 1
      expect(Question.published).to include cat2
    end
  end

  describe '.by_position' do
    it 'order question by position ascending' do
      cat1 = create :question, published: false, position: 6
      cat2 = create :question, published: true, position: 5

      questions = Question.by_position

      expect(questions.first).to eq cat2
      expect(questions.last).to eq cat1
    end
  end
end
