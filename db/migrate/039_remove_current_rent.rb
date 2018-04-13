class RemoveCurrentRent < ActiveRecord::Migration
  def self.up
    AddCurrentRent.down
  end

  def self.down
    AddCurrentRent.up
  end
end
