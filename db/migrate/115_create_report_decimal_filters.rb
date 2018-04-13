class CreateReportDecimalFilters < ActiveRecord::Migration
  def self.up
    create_table :report_decimal_filters do |t|
      t.integer :report_id, :relation_attribute_id
      t.decimal :search_value
      t.timestamps
    end
  end

  def self.down
    drop_table :report_decimal_filters
  end
end
