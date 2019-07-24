# frozen_string_literal: true

FactoryBot.define do
  password = Faker::Internet.password

  factory :user do
    sequence(:email) { |n| "example#{n}@test.com" }
    sequence(:username) { |n| "name#{n}" }
    password { password }
    password_confirmation { password }

    trait :no_username do
      username {}
    end

    trait :too_long_username do
      username { Faker::Lorem.characters(16) }
    end

    trait :too_short_username do
      username { Faker::Lorem.characters(2) }
    end

    trait :create_with_novels do
      after(:create) do |user|
        create_list(:novel, 3, user: user, genre_id: 1)
      end
    end

    trait :create_with_novel_contents do
      after(:create) do |user|
        create_list(:novel_content, 3, user: user, novel_id: 1)
      end
    end
  end
end
