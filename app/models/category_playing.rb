class CategoryPlaying < ApplicationRecord
  validates :total_questions, :total_corrects, :point, :category_token, presence: true

  belongs_to :category
  belongs_to :user
end
