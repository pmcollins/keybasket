class AddPropertyPropertyPhotoColumn < ActiveRecord::Migration
  def self.up
    add_column :properties, :property_photo_id, :integer
  end

  def self.down
    remove_column :properties, :property_photo_id
  end
end
