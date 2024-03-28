FactoryBot.define do
  factory :match do
    date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
  end
end