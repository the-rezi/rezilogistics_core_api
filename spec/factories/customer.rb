FactoryBot.define do
	factory :customer do
		name { Faker::Lorem.word }
		address { Faker::Lorem.word }
		major_intersection { Faker::Lorem.word }
		phone_number { Faker::Lorem.word }
	end
end