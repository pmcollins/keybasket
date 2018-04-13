class CreateAccountTypes < ActiveRecord::Migration
  def self.up
    create_table :account_types do |t|
      t.column :name, :string, :null => false
      t.column :inverted, :boolean, :null => false
    end
  end

  def self.down
    drop_table :account_types
  end
end
