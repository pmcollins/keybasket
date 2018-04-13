class DropReportFilters < ActiveRecord::Migration
  def self.up
    CreateReportFilters.down
  end

  def self.down
    CreateReportFilters.up
  end
end
