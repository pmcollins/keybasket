class AddManagerOfficePhoneColumn < ActiveRecord::Migration
  def self.up
    add_column :managers, :office_phone, :string
  end

  def self.down
    remove_column :managers, :office_phone
  end
end
