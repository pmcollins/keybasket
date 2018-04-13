class CreateAdministrators < ActiveRecord::Migration
  def self.up
    create_table :administrators do |t|
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :administrators
  end
end
