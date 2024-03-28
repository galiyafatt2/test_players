FactoryBot.define do
  factory :metric do
    name { "Metric #{Faker::Number.unique.number(digits: 2)}" }
  end
end