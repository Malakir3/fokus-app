FactoryBot.define do
  factory :standard do
    large   { Faker::Number.number(digits: 4) }
    medium  { Faker::Number.number(digits: 3) }
    small   { Faker::Number.number(digits: 2) }
    association :user
    association :menu
  end
end
