class CreatePropertyPhotos < ActiveRecord::Migration
  def self.up
    create_table :property_photos do |t|
      t.column :property_id, :integer
      t.column :photo_id, :integer
      t.column :caption, :text
    end
  end

  def self.down
    drop_table :property_photos
  end
end
