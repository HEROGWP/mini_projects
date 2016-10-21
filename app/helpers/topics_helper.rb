module TopicsHelper
	def tags(tag)
  	tag.split(" ")
  end

  def set_topic_images(topic)
		if topic.pictures.blank?
			pictures = ["/default/medium.JPG"]
		else
			pictures = topic.pictures.map{ |picture| picture.photo.url(:medium)}
		end
	end

	def set_image(source)
		if source.pictures.blank?
			return "/default/thumb.JPG"
		else
			return source.pictures.first.photo.url(:thumb)
		end
	end
end
