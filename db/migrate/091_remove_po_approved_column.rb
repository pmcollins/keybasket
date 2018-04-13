class RemovePoApprovedColumn < ActiveRecord::Migration
  def self.up
    AddPoApprovedColumn.down
  end

  def self.down
    AddPoApprovedColumn.up
  end
end
