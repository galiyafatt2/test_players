FactoryBot.define do
  factory :team do
    name { "Team #{Faker::Number.unique.number(digits: 2)}" }
  end
end