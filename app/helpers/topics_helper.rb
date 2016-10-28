module TopicsHelper
	def tags(tag)
  	tag.split(" ")
  end

  def set_topic_images(topic, style)
		if topic.pictures.blank?
			pictures = ["/images/#{style}/missing.JPG"]
		else
			pictures = topic.pictures.map{ |picture| picture.photo.url(style)}
		end
	end
end
