class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

	def user_name
		self.email.split("@").first
	end

	def create_pictures(photos)
    unless photos.blank?
    	photos.each do |photo|
  			self.pictures.create(:photo => photo)
  		end
    end
  end

  def destroy_pictures(photos)
  	unless self.pictures.blank?
  		self.pictures.destroy_all
  		byebug
  	end
  end
end
