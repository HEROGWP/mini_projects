class CreateTopicCategoryships < ActiveRecord::Migration[5.0]
  def change
    create_table :topic_categoryships do |t|
    	t.integer :topic_id
    	t.integer :category_id

      t.timestamps
    end
    add_index :topic_categoryships, :topic_id
    add_index :topic_categoryships, :category_id

  end
end
