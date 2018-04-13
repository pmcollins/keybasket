class CreateFloorPlans < ActiveRecord::Migration
  def self.up
    create_table :floor_plans do |t|
      t.column :name, :string
      t.column :property_id, :integer
      t.column :bedrooms, :integer
      t.column :bathrooms, :integer
      t.column :half_bath, :boolean
      t.column :sq_ft, :integer
    end
  end

  def self.down
    drop_table :floor_plans
  end
end
