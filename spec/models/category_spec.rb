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

  describe '.search' do
    context 'content' do
      let!(:category1) { create :category, name: "my video numero uno ojo's" }
      let!(:category2) { create :category, name: ' merah ##bagus @@sekali koyo"s' }

      it 'with keywords' do
        expect(Category.search('numero')).to be_present
        expect(Category.search('putih')).not_to be_present
        expect(Category.search('num')).to be_present
        expect(Category.search('')).not_to be_present
        expect(Category.search(' merah ##bag @@ ')).to be_present
        expect(Category.search("ojo")).to be_present
        expect(Category.search('koyo"s')).to be_present
      end
    end

    context 'ordering' do
      context 'varying priority' do
        let(:name) { "Starts to Love (by Hakmal Insyan)" }
        let(:description) { "Band: Melodrama\r\nAuthor: Hakmal Insyan" }

        let!(:category_with_desc)  { create :category, description: "#{name}\r\n #{description}" }
        let!(:category_with_name) { create :category, name: name }

        before do
          category_with_name.reload
          category_with_desc.reload
        end

        context 'by search result on name first then by search results on description' do
          it "will have results" do
            categories = Category.search(name)
            expect(categories).to include category_with_name
            expect(categories).to include category_with_desc
          end
        end

        context 'by search result on description if search result on name not found' do
          it "have results" do
            results = Category.search(description)

            expect(results.first).to eq category_with_desc
            expect(results.second).to be_nil
          end
        end
      end

      context 'when the search results are of equal priority' do
        context 'it breaks ties by using the publish_date column' do
          let!(:earlier_category) { create :category, name: "Mamamia", created_at: DateTime.yesterday }
          let!(:later_category)   { create :category, name: "Mamamia", created_at: DateTime.now }

          it "have result" do
            results = Category.search("mamamia")
            
            expect(results.first).to eq later_category
            expect(results.second).to eq earlier_category
          end
        end
      end
    end

    context "when search contains keywords less than 3 char" do
      let!(:category_1) { create :category, name: "do remi" }
      let!(:category_2) { create :category, name: "faso lasi" }
      let!(:category_3) { create :category, name: "remi fa" }
      let!(:category_4) { create :category, name: "do misol" }

      it "remove all keywords less than three and return relevant category" do
        categories = Category.search("do remi")

        expect(categories.size).to eq 2
        expect(categories).to     include category_1
        expect(categories).to     include category_3
        expect(categories).not_to include category_2
        expect(categories).not_to include category_4
      end

      it "return empty when all keywords less than 3 chars" do
        categories = Category.search("do fa")
        expect(categories).to be_empty
      end
    end
  end
end
