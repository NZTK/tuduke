# frozen_string_literal: true

FactoryBot.define do
  factory :genre do
    sequence(:genre_name) { |n| "genre_name#{n}" }

    trait :no_genre_name do
      username {}
    end
  end
end
