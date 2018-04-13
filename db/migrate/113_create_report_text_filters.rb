class CreateReportTextFilters < ActiveRecord::Migration
  def self.up
    create_table :report_text_filters do |t|
      t.string :search_value
      t.integer :report_id, :relation_attribute_id
      t.timestamps
    end
  end

  def self.down
    drop_table :report_text_filters
  end
end
