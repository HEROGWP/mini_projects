class Picture < ApplicationRecord
	belongs_to :picturetable, :polymorphic => true

	has_attached_file :photo, styles: { medium: "200x200>", thumb: "50x50>" }, default_url: "/default/missing.JPG"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

end
