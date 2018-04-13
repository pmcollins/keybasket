class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :phone, :string
      t.column :email, :string
    end
  end

  def self.down
    drop_table :contacts
  end
end
