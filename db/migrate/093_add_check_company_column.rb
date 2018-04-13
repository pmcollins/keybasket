class AddCheckCompanyColumn < ActiveRecord::Migration
  def self.up
    add_column :checks, :company_id, :integer
  end

  def self.down
    remove_column :checks, :company_id
  end
end
