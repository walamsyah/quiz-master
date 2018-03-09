class Category < ApplicationRecord
  validates :name, :image, presence: true

  has_many :questions
  has_many :question_answers
  has_many :category_playings

  scope :published, -> { where(published: true) }
  scope :by_name, -> { order(name: :asc) }
  scope :latest, -> { order(id: :desc) }

  mount_uploader :image, CategoryImageUploader

  def self.popular
     playings_query = CategoryPlaying
      .select("category_id, COUNT(*) AS count")
      .group("category_id")
      .order("count DESC")
    Category.select("categories.*, playings.count").published
      .joins("JOIN (#{playings_query.to_sql}) as playings ON categories.id = playings.category_id")
      .order("playings.count DESC")
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def total_questions
    questions.published.count
  end
end
