class RenameUsersToLogins < ActiveRecord::Migration
  def self.up
    rename_table :users, :logins
  end

  def self.down
    rename_table :logins, :users
  end
end
