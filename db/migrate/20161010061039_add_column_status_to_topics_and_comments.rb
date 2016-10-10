class AddColumnStatusToTopicsAndComments < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics, :status, :string, :default => "draft"
  	add_column :comments, :status, :string, :default => "draft"
  end
end
