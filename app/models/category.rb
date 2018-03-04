class Category < ApplicationRecord
  validates :name, presence: true

  has_many :questions

  scope :published, -> { where(published: true) }
  scope :by_name, -> { order(name: :asc) }
  scope :latest, -> { order(id: :desc) }
end
