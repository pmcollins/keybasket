class DropPropertyReports < ActiveRecord::Migration
  def self.up
    CreatePropertyReports.down
  end

  def self.down
    CreatePropertyReports.up
  end
end
