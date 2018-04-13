class AddFloorPlanColumns < ActiveRecord::Migration
  def self.up
    add_column :units, :floor_plan_id, :integer
  end

  def self.down
    remove_column :units, :floor_plan_id
  end
end
