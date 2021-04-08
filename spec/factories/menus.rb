FactoryBot.define do
  factory :menu do
    title     { Faker::Food.fruits }
    amount    { Faker::Number.number(digits: 3) }
    unit      { Faker::Measurement.weight(amount: 'none') }
    calorie   { Faker::Number.number(digits: 3) }
    bar_code  { Faker::Number.leading_zero_number(digits: 9) }

    after(:build) do |menu|
      menu.images.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
