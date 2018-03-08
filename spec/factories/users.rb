FactoryBot.define do
  factory :user do
    name Faker::Name.name
    sequence :email do |i|
      username = Faker::Internet.user_name(nil, %w(_))+"-#{i}-" + SecureRandom.hex(3)
      username + '@gmail.com'
    end
    password "password"
  end
end
