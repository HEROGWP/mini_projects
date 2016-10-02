class Comment < ApplicationRecord
	validates_presence_of :content

	belongs_to :user
	belongs_to :topic, :counter_cache => true
end
