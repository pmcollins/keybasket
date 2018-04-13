class FloorPlanDescription < ActiveRecord::Migration
  def self.up
    add_column :floor_plans, :description, :text
  end

  def self.down
    remove_column :listings, :description
  end
end
