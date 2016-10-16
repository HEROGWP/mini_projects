class Profile < ApplicationRecord
	validates_presence_of :nickname
	belongs_to :user

	def user_name
		self.email.split("@").first
	end
end
