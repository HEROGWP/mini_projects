class Profile < ApplicationRecord
	validates_presence_of :nickname
	belongs_to :user
end
