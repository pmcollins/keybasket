class CreateOperators < ActiveRecord::Migration
  def self.up
    create_table :operators do |t|
      t.string :name, :description, :method_name
      t.timestamps
    end
  end

  def self.down
    drop_table :operators
  end
end
