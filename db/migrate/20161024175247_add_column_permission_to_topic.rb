class AddColumnPermissionToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics, :permission, :string
  end
end
