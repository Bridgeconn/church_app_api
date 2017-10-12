class Event < ApplicationRecord
	belongs_to :church_app
	has_one :picture, class_name: 'Picture', as: :imageable, dependent: :destroy
end
