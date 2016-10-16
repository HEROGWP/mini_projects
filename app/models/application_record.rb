class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

	def user_name
		self.email.split("@").first
	end
end
