class ChurchApp < ApplicationRecord
	belongs_to :user, inverse_of: :church_app
	has_many :events

	has_many :members, :class_name => 'User'
end
