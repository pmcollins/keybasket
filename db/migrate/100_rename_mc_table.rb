class RenameMcTable < ActiveRecord::Migration
  def self.up
    rename_table 'management_coordinators', 'coordinators'
  end

  def self.down
    rename_table 'coordinators', 'management_coordinators'
  end
end
