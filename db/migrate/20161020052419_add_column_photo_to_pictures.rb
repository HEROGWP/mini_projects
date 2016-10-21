class AddColumnPhotoToPictures < ActiveRecord::Migration[5.0]
  def up
    add_attachment :pictures, :photo
  end

  def down
    remove_attachment :pictures, :photo
  end
end
