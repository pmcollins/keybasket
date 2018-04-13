class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column :normalized, :binary
      t.column :thumb, :binary
      t.column :date_added, :date
    end
  end

  def self.down
    drop_table :photos
  end
end
