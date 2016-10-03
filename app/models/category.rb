class Category < ApplicationRecord
	has_many :topic_categoryships, :dependent => :destroy
	has_many :topics, :through => :topic_categoryships
end
