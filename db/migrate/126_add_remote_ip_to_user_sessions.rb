class AddRemoteIpToUserSessions < ActiveRecord::Migration
  def self.up
    add_column :user_sessions, :remote_ip, :text
  end

  def self.down
    remove_column :user_sessions, :remote_ip
  end
end
