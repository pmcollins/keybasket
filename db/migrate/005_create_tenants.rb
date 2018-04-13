class CreateTenants < ActiveRecord::Migration
  def self.up
    create_table :tenants do |t|
      t.column :unit_id, :integer
      t.column :contact_id, :integer
    end
  end

  def self.down
    drop_table :tenants
  end
end
