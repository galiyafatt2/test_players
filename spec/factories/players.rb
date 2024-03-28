FactoryBot.define do
  factory :player do
    name { "Player #{Faker::Name.unique.first_name}" }
    team
  end
end