class Video < ApplicationRecord
	validates_presence_of :name
	validates :url_address, format: { with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, message: "only allows letters",:multiline => true }
end
