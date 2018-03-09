FactoryBot.define do
  factory :category_playing do
    category_token SecureRandom.hex(3)
    total_questions 1
    total_corrects 1
    point "1.0"
    category
    user
  end
end
