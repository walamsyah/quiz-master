class Question < ApplicationRecord
  validates :content, :answer, :position, presence: true

  belongs_to :category
end
