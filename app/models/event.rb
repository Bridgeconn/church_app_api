class Event < ApplicationRecord
	belongs_to :church_app
	mount_uploaders :event_avatars, AttachmentUploader
	has_one :picture, class_name: 'Picture', as: :imageable, dependent: :destroy
end
