require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has columns" do
    should have_db_column(:name).of_type(:string)
    should have_db_column(:description).of_type(:text)
    should have_db_column(:image).of_type(:string)
    should have_db_column(:published).of_type(:boolean)
  end

  it "has validation" do
    is_expected.to validate_presence_of :name
    is_expected.to validate_presence_of :image
  end

  it "has associations" do
    is_expected.to have_many :questions
    is_expected.to have_many :question_answers
  end

  describe '#popular' do
    it "will order by most frequent plays of categories" do
      cat1 = create :category
      cat2 = create :category

      create_list :category_playing, 2, category: cat2
      create :category_playing, category: cat1

      categories = Category.popular

      expect(categories.first).to eq cat2
      expect(categories.last).to eq cat1
    end
  end

  describe '.published' do
    it 'show published category' do
      cat1 = create :category, published: false
      cat2 = create :category, published: true

      expect(Category.published.count).to eq 1
      expect(Category.published).to include cat2
    end
  end

  describe '.by_name' do
    it 'order category by name ascending' do
      cat1 = create :category, published: false, name: "About Jakarta"
      cat2 = create :category, published: true, name: "About Bandung"

      categories = Category.by_name

      expect(categories.first).to eq cat2
      expect(categories.last).to eq cat1
    end
  end

  describe '.latest' do
    before do
      ActiveRecord::Base.connection.execute("TRUNCATE questions")
      ActiveRecord::Base.connection.execute("TRUNCATE categories")
    end

    it 'order category by last id descending' do
      cat1 = create :category, published: false, id: 7777
      cat2 = create :category, published: true, id: 9999

      categories = Category.latest

      expect(categories.first).to eq cat2
      expect(categories.last).to eq cat1
    end
  end

  describe ".to_param" do
    it "will show slug url" do
      category = create :category
      expect(category.to_param).to eq "#{category.id}-#{category.name.parameterize}"
    end
  end

  describe ".total_questions" do
    it "will count how many published questions" do
      category = create :category
      question1 = create :question, category: category, published: false
      question2 = create :question, category: category, published: true

      expect(category.total_questions).to eq 1
    end
  end
end
