FactoryBot.define do
  factory :category do
    name Faker::Name.title
    description Faker::Lorem.paragraph
    published true
    image "MyString"
  end
end
