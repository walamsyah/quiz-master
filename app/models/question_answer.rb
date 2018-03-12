class QuestionAnswer < ApplicationRecord
  validates :answer, :category_token, presence: true
  
  belongs_to :category
  belongs_to :question
  belongs_to :user
end
