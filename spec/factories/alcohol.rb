FactoryBot.define do
  factory :alcohol do
    name { Faker::Lorem.characters(number:10) }
  end
end