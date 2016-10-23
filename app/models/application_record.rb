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
  	unless photos.blank?
  		self.pictures.destroy_all
  	end
  end

  def self.change_status
    self.where(:status => "scheduled").each do |schedule|
      if Time.now > schedule.publish_time
        schedule.update(:status => "published")
      end
    end
  end
end
