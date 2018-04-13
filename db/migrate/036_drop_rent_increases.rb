class DropRentIncreases < ActiveRecord::Migration
  def self.up
    CreateRentIncreases.down
  end

  def self.down
    CreateRentIncreases.up
  end
end
