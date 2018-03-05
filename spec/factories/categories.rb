FactoryBot.define do
  factory :category do
    name Faker::Name.title
    description Faker::Lorem.paragraph
    published true
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'image.jpg')) }
  end
end
