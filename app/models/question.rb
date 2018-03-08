class Question < ApplicationRecord
  validates :content, :answer, :position, presence: true

  belongs_to :category
  has_many :question_answers

  scope :published, -> { where(published: true) }
  scope :by_position, -> { order(position: :asc) }

  def check_correct_answer?(input_answer)
    return true if answer.to_s.downcase == input_answer.to_s.downcase
    set_to_number(answer) == set_to_number(input_answer)
  end

  private

  def set_to_number(string)
    string = string.to_s.downcase
    numbers = NumbersInWords.in_numbers(string)
    
    if numbers.is_a?(Float) || numbers.is_a?(Integer)
      number = (numbers.to_i == numbers) ? numbers.to_i : numbers
      word = NumbersInWords.in_words(number, NumbersInWords.language)
      normalized = string.gsub(word, number.to_s)
    elsif numbers.is_a? Array
      normalized = string
      numbers.each do |number|
        word = NumbersInWords.in_words(number, NumbersInWords.language)
        normalized = normalized.gsub(word, number.to_s)
      end
    end

    normalized
  end
end
