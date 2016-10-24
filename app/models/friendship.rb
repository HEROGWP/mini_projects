class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, :class_name => "User"

	scope :confirm, -> { where(:relationship => "confirm") }
	scope :confirming, -> { where(:relationship => "confirming") }
	scope :ignore, -> { where(:relationship => "ignore") }

end
