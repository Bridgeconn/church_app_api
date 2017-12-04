class Event < ApplicationRecord
	belongs_to :church_app
	mount_uploader :event_avtars, AttachmentUploader
	has_one :picture, class_name: 'Picture', as: :imageable, dependent: :destroy
end
