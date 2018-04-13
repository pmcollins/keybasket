class CreateManagers < ActiveRecord::Migration
  def self.up
    create_table :managers do |t|
      t.column :company_id, :integer
      t.column :contact_id, :integer
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :managers
  end
end
