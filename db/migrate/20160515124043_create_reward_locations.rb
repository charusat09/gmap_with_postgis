class CreateRewardLocations < ActiveRecord::Migration
  def change
    create_table :reward_locations do |t|
    	t.string :name
    	t.st_polygon :polygon, geographic: true

      t.timestamps null: false
    end
  end
end
