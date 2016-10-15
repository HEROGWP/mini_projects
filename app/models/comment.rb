class Comment < ApplicationRecord
	validates_presence_of :content

	belongs_to :user
	belongs_to :topic, :counter_cache => true

	has_attached_file :picture, styles: { medium: "100x100>", thumb: "50x50>" }, default_url: "/default/missing.JPG"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
