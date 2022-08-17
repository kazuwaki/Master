# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    name { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:10) }
    type_id { Faker::Lorem.characters(number:10) }
    alcohol_id { Faker::Lorem.characters(number:10) }
    customer
  end
end
