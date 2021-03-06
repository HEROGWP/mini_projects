class Topic < ApplicationRecord
	validates_presence_of :title
	belongs_to :user
	has_many :comments, :dependent => :destroy
	has_many :topic_categoryships, :dependent => :destroy
	has_many :categories, :through => :topic_categoryships
	has_many :favorites, :dependent => :destroy
	has_many :likes, :dependent => :destroy
	has_many :like_users, :through => :likes, :source => :user

  has_many :subscribes, :dependent => :destroy

  has_many :pictures, :as => :picturetable, :dependent => :destroy
	
end
