class ChurchApp < ApplicationRecord
	belongs_to :user
	has_many :events

	has_many :members, :class_name => 'User'
end
