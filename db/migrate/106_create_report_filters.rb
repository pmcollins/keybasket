class CreateReportFilters < ActiveRecord::Migration
  def self.up
    create_table :report_filters do |t|
      t.integer :report_id, :relation_attribute_id
      t.timestamps
    end
  end

  def self.down
    drop_table :report_filters
  end
end
