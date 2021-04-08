FactoryBot.define do
  factory :graph do
    date      { Faker::Date.between(from: 3.month.ago, to: Date.today) }
    calorie   { Faker::Number.number(digits: 3) }
  end
end
