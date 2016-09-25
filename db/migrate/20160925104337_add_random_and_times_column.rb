class AddRandomAndTimesColumn < ActiveRecord::Migration[5.0]
  def change
  add_column :videos, :random, :string
  add_column :videos, :times, :integer

  end
end
