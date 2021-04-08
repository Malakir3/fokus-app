FactoryBot.define do
  factory :user do
    nickname              { Faker::FunnyName.name }
    email                 { Faker::Internet.free_email }
    firstname             { Faker::Name.first_name }
    lastname              { Faker::Name.last_name }
    password              { Faker::Internet.password(min_length: 6, max_length: 10, mix_case: true, special_characters: true) }
    password_confirmation { password }
    birthday              { Faker::Date.between(from: 50.years.ago, to: Date.today) }
  end
end
