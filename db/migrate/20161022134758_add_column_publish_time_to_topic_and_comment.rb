class AddColumnPublishTimeToTopicAndComment < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics, :publish_time, :datetime
  	add_column :comments, :publish_time, :datetime
  end
end
