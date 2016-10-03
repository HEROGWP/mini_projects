class Topic < ApplicationRecord
	validates_presence_of :title
	belongs_to :user
	has_many :comments, :dependent => :destroy
	has_many :topic_categoryships, :dependent => :destroy
	has_many :categories, :through => :topic_categoryships

end
