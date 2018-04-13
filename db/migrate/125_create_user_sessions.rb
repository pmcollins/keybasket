class CreateUserSessions < ActiveRecord::Migration
  def self.up
    create_table :user_sessions do |t|
      t.integer :login_id
      t.datetime :logged_in_at, :logged_out_at
    end
  end

  def self.down
    drop_table :user_sessions
  end
end
