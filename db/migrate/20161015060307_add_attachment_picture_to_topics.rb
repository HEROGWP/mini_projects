class AddAttachmentPictureToTopics < ActiveRecord::Migration
  def self.up
    change_table :topics do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :topics, :picture
  end
end
