class CreateFloorPlanPhotos < ActiveRecord::Migration
  def self.up
    create_table :floor_plan_photos do |t|
      t.column :floor_plan_id, :integer
      t.column :photo_id, :integer
      t.column :caption, :text
    end
  end

  def self.down
    drop_table :floor_plan_photos
  end
end
