class CreateMeasureUnits < ActiveRecord::Migration
  def self.up
    create_table :measure_units do |t|
      t.column :name, :string
      t.column :ordering, :integer
    end
  end

  def self.down
    drop_table :measure_units
  end
end
