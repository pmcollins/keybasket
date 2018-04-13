class AddFloorPlanNominalRentColumn < ActiveRecord::Migration
  def self.up
    add_column :floor_plans, :nominal_rent, :integer
  end

  def self.down
    remove_column :floor_plans, :nominal_rent
  end
end
