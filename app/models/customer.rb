class Customer < ApplicationRecord
	# validations
	validates_presence_of :name, :address, :major_intersection, :phone_number
end
