FactoryBot.define do
  factory :question_answer do
    answer Faker::Name.first_name
    category_token SecureRandom.hex(3)
    is_correct false
    category
    question
    user
  end
end
