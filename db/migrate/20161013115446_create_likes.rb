class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
    	t.integer :user_id
    	t.integer :topic_id
      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :topic_id
  end
end
