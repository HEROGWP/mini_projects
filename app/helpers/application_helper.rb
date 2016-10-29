module ApplicationHelper
	def set_image(source, style)
		if source.pictures.blank?
			return "/images/#{style}/missing.JPG"
		else
			return source.pictures.first.photo.url(style)
		end
	end
	
	def og_image_url(image_path)
		request.protocol + request.host_with_port + image_path
	end

	def set_video_url(path)
		request.protocol + request.host_with_port + '/' + path
	end
end
