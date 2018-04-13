class CreateFormerTenants < ActiveRecord::Migration
  def self.up
    create_table :former_tenants do |t|
      t.column :move_out_id, :integer
      t.column :contact_id, :integer
    end
  end

  def self.down
    drop_table :former_tenants
  end
end
