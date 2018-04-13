class CreateReportBooleanFilters < ActiveRecord::Migration
  def self.up
    create_table :report_boolean_filters do |t|
      t.integer :report_id, :relation_attribute_id
      t.boolean :search_value
      t.timestamps
    end
  end

  def self.down
    drop_table :report_boolean_filters
  end
end
