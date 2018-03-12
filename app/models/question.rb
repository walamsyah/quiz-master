class Question < ApplicationRecord
  validates :content, :answer, :position, presence: true

  belongs_to :category
  has_many :question_answers

  scope :published, -> { where(published: true) }
  scope :by_position, -> { order(position: :asc) }

  def check_correct_answer?(input)
    the_answer = answer.to_s.downcase
    input      = input.to_s.downcase

    return true if the_answer == input

    set_to_number(the_answer) == set_to_number(input)
  end

  private

  def set_to_number(string)
    number = NumbersInWords.in_numbers(string)

    if number.is_a?(Float) || number.is_a?(Integer)
      result = number
    else
      result = string
    end

    return string if result == 0

    result
  end
end
