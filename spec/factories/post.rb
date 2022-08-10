FactoryBot.define do
  factory :post do
    name { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:10) }
    type select(value = "1", from: "post[type_id]")
    alcohol select(value = "1", from: "post[alcohol_id]")
    customer
  end
end
