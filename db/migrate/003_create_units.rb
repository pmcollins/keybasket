class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.column :apt, :string
      t.column :floor, :integer
      t.column :phone, :string
      t.column :property_id, :integer
    end
  end

  def self.down
    drop_table :units
  end
end
