FactoryBot.define do
	factory :employee do
		name { Faker::Lorem.word }
		phone_number { Faker::Lorem.word }
		badge_id { Faker::Lorem.word }
	end
end