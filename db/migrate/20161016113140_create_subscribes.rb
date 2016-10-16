class CreateSubscribes < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribes do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
    add_index :subscribes, :user_id
    add_index :subscribes, :topic_id
  end
end
