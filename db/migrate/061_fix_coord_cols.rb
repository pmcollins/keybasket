class FixCoordCols < ActiveRecord::Migration
  def self.up
    add_column    :management_coordinators, :contact_id, :integer
    remove_column :management_coordinators, :user
  end

  def self.down
    add_column    :management_coordinators, :user, :integer
    remove_column :management_coordinators, :contact_id
  end
end
