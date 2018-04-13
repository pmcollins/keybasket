class RenameUseridColumns < ActiveRecord::Migration
  def self.up
    rename_column :managers, :user_id, :login_id
    rename_column :management_coordinators, :user_id, :login_id
    rename_column :administrators, :user_id, :login_id
  end

  def self.down
    rename_column :managers, :login_id, :user_id
    rename_column :management_coordinators, :login_id, :user_id
    rename_column :administrators, :login_id, :user_id
  end
end
