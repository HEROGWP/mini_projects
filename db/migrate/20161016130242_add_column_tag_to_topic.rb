class AddColumnTagToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics, :tag, :string
  	add_index :topics, :tag
  end
end
