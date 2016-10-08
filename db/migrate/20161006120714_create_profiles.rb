class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
    	t.string :nickname
    	t.date :birthday
    	t.text :bio
    	t.integer :user_id
      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
