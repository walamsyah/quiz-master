class Category < ApplicationRecord
  include PgSearch

  validates :name, :image, presence: true

  has_many :questions
  has_many :question_answers
  has_many :category_playings

  scope :published, -> { where(published: true) }
  scope :by_name, -> { order(name: :asc) }
  scope :latest, -> { order(id: :desc) }

  mount_uploader :image, CategoryImageUploader

  pg_search_scope :search, {
    against: %i(name description),
    using: {
      tsearch: {
        prefix: true,
        exact_number: true,
        strip_leading_zero: true,
        tsvector_column: 'search_text',
        any_word: false
      }
    },
    order_within_rank: "categories.id DESC"
  }

  def self.search_text_query(trigger: false)
    trigger_prefix = trigger ? "new." : ""
    <<-SQL
      (
        setweight(to_tsvector('simple', replace(coalesce(#{trigger_prefix}name, ''), '''', '-')), 'A') ||
        setweight(to_tsvector('simple', replace(coalesce(#{trigger_prefix}description, ''), '''', '-')), 'B')
      )
    SQL
  end

  trigger.before(:insert, :update) do
    <<-SQL
      new.search_text := #{Category.search_text_query(trigger: true)}
    SQL
  end

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
