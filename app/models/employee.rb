class Employee < ApplicationRecord
	# validation
	validates_presence_of :name, :phone_number, :badge_id
end
