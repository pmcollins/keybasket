class AddUnitFlagColumn < ActiveRecord::Migration
  def self.up
    add_column :units, :flagged, :boolean
  end

  def self.down
    remove_column :units, :flagged
  end
end
