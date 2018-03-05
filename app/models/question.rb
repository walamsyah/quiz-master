class Question < ApplicationRecord
  validates :content, :answer, :position, presence: true

  belongs_to :category

  scope :published, -> { where(published: true) }
  scope :by_position, -> { order(position: :asc) }
end
