class AddColumnViewsToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :views, :integer, :default => 0
  end
end
