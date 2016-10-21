class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
    	t.belongs_to :picturetable, :polymorphic => true
      t.timestamps
    end
  end
end
