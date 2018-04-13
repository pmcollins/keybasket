class CreateRelationAttributesReports < ActiveRecord::Migration
  def self.up
    create_table :relation_attributes_reports do |t|
      t.integer :report_id, :relation_attribute_id
    end
  end

  def self.down
    drop_table :notes
  end
end
