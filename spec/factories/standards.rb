FactoryBot.define do
  factory :standard do
    association :user
    association :menu

    after(:build) do |standard|
      standard.large = standard.menu.amount * 3
      standard.medium = standard.menu.amount
      standard.small = standard.menu.amount / 3
    end
  end
end
