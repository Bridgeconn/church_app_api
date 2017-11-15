class ChurchApp < ApplicationRecord
	belongs_to :user, inverse_of: :church_app
	has_many :events

	has_many :members, :class_name => 'User'

	before_create :church_id_generate

	def church_id_generate
    self.church_app_id = "ChurchApp_" + (0...5).map { ('1'..'10').to_a[rand(4)] }.join
  end
end
