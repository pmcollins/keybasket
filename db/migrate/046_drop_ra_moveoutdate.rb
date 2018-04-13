class DropRaMoveoutdate < ActiveRecord::Migration
  def self.up
    remove_column :rental_agreements, :move_out_date
  end

  def self.down
    add_column :rental_agreements, :move_out_date, :date
  end
end
