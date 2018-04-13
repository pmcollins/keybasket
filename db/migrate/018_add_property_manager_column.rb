class AddPropertyManagerColumn < ActiveRecord::Migration
  def self.up
    add_column :properties, :manager_id, :integer
  end

  def self.down
    remove_column :properties, :manager_id
  end
end
