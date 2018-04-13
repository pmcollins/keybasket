class DropFormerTenant < ActiveRecord::Migration
  def self.up
    CreateFormerTenants.down
  end

  def self.down
    CreateFormerTenants.up
  end
end
