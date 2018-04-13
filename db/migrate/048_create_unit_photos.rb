class CreateUnitPhotos < ActiveRecord::Migration
  def self.up
    create_table :unit_photos do |t|
      t.column :unit_id, :integer
      t.column :photo_id, :integer
      t.column :caption, :text
    end
  end

  def self.down
    drop_table :unit_photos
  end
end
