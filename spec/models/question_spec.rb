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
    is_expected.to have_many :question_answers
  end

  describe '.published' do
    it 'show published question' do
      question1 = create :question, published: false
      question2 = create :question, published: true

      expect(Question.published.count).to eq 1
      expect(Question.published).to include question2
    end
  end

  describe '.by_position' do
    it 'order question by position ascending' do
      question1 = create :question, published: false, position: 6
      question2 = create :question, published: true, position: 5

      questions = Question.by_position

      expect(questions.first).to eq question2
      expect(questions.last).to eq question1
    end
  end

  describe '.check_correct_answer?' do
    it "will return false when input='Jakarta' and answer='Bandung'" do
      question = create :question, answer: "Bandung"
      expect(question.check_correct_answer?('Jakarta')).to eq false
    end
    
    it "will return true when input='JakArTa' and answer='Jakarta'" do
      question = create :question, answer: "Jakarta"
      expect(question.check_correct_answer?('JakArTa')).to eq true
    end
    
    it "will return true when input='21' and answer='Twenty One'" do
      question = create :question, answer: "Twenty One"
      expect(question.check_correct_answer?(21)).to eq true
    end

    it "will return true when input='21' and answer='Twenty-One'" do
      question = create :question, answer: "Twenty-One"
      expect(question.check_correct_answer?(21)).to eq true
    end

    it "will return true when input='21.5' and answer='Twenty-One Point Five'" do
      question = create :question, answer: "Twenty-One Point Five"
      expect(question.check_correct_answer?(21.5)).to eq true
    end

    it "will return true when input='21.5' and answer='21.50'" do
      question = create :question, answer: "21.50"
      expect(question.check_correct_answer?(21.5)).to eq true
    end

    it "will return false when input='20' and answer='Twenty-One'" do
      question = create :question, answer: "Twenty-One"
      expect(question.check_correct_answer?(20)).to eq false
    end

    it "will return true when input='110' and answer='One Hundred And Ten'" do
      question = create :question, answer: "One Hundred And Ten"
      expect(question.check_correct_answer?(110)).to eq true
    end
  end
end
