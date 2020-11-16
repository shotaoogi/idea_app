# frozen_string_literal: true

FactoryBot.define do
  factory :idea do
    body { Faker::Lorem.paragraph }
    association :category
  end
end
