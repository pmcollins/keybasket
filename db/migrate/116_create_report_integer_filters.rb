class CreateReportIntegerFilters < ActiveRecord::Migration
  def self.up
    create_table :report_integer_filters do |t|
      t.integer :report_id, :relation_attribute_id, :search_value
      t.timestamps
    end
  end

  def self.down
    drop_table :report_integer_filters
  end
end
