FactoryBot.define do
  factory :question do
    content Faker::Lorem.paragraph
    answer Faker::Name.name
    published true
    position 1
    image "MyString"
    category
  end
end
