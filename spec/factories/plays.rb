FactoryBot.define do
  factory :play do
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
  end
end