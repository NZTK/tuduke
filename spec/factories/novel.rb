FactoryBot.define do
	factory :novel do
		sequence(:novel_title) { |n| "novel_title#{n}"}
		sequence(:novel_about) { |n| "novel_about#{n}"}


		trait :no_novel_title do
			novel_title {}
		end

		trait :no_novel_about do
			novel_about {}
		end


		trait :too_long_title do
			novel_title { Faker::Lorem.characters(51) }
		end

		trait :too_short_about do
			novel_title { Faker::Lorem.characters(9) }
		end

		trait :too_long_about do
			novel_title { Faker::Lorem.characters(10001) }
		end
	end
end