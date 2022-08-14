FactoryBot.define do
  factory :post do
    name { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:10) }
    customer
  end
end
