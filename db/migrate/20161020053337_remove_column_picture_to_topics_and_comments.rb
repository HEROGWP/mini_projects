class RemoveColumnPictureToTopicsAndComments < ActiveRecord::Migration[5.0]
  def up
  	remove_attachment :topics, :picture
  	remove_attachment :comments, :picture
  end

  def down
    add_attachment :topics, :picture
    add_attachment :comments, :picture    
  end
end
