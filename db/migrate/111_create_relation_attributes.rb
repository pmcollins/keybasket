class CreateRelationAttributes < ActiveRecord::Migration
  def self.up
    create_table :relation_attributes do |t|
      t.integer :relation_id
      t.string :name, :attribute_type
      t.timestamps
    end
  end

  def self.down
    drop_table :relation_attributes
  end
end
