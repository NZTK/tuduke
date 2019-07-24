FactoryBot.define do
	factory :novel_content do
		sequence(:novel_content_title) { |n| "novel_content_title#{n}"}
		# sequence(:novel_content_text) { |n| "novel_content_text#{n}"}
		sequence(:novel_content_forewords) { |n| "novel_content_forewords#{n}"}
		sequence(:novel_content_afterwords) { |n| "novel_content_afterwords#{n}"}
		novel_content_text {"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}


		trait :no_content_title do
			novel_content_title {}
		end

		trait :no_text do
			novel_content_text {}
		end


		trait :too_long_content_title do
			novel_content_title { Faker::Lorem.characters(51) }
		end

		trait :too_short_text do
			novel_content_text { Faker::Lorem.characters(299) }
		end

		trait :too_long_text do
			novel_content_text { Faker::Lorem.characters(50001) }
		end
		trait :too_long_forewords do
			novel_content_forewords { Faker::Lorem.characters(501) }
		end
		trait :too_long_afterwords do
			novel_content_afterwords { Faker::Lorem.characters(501) }
		end
	end
end