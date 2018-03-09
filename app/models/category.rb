class Category < ApplicationRecord
  validates :name, :image, presence: true

  has_many :questions
  has_many :question_answers
  has_many :category_playings

  scope :published, -> { where(published: true) }
  scope :by_name, -> { order(name: :asc) }
  scope :latest, -> { order(id: :desc) }

  mount_uploader :image, CategoryImageUploader

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def total_questions
    questions.published.count
  end
end
