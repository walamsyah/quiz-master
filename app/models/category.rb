class Category < ApplicationRecord
  validates :name, :image, presence: true

  has_many :questions

  scope :published, -> { where(published: true) }
  scope :by_name, -> { order(name: :asc) }
  scope :latest, -> { order(id: :desc) }

  mount_uploader :image, CategoryImageUploader
end
