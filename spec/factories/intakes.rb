FactoryBot.define do
  factory :intake do
    date        { Faker::Date.between(from: 3.month.ago, to: Date.today) }
    timing_id   { Faker::Number.between(from: 2, to: 4) }
    value_id    { Faker::Number.between(from: 2, to: 4) }
    association :user
    association :menu
  end
end
