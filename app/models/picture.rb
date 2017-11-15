class Picture < ApplicationRecord
	belongs_to :imageable, :polymorphic => true
	mount_uploader :attachment, AttachmentUploader
end
