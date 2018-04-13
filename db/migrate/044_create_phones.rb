class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.column :number, :string
      t.column :tag, :string
      t.column :phoneable_id, :integer
      t.column :phoneable_type, :string
    end
  end

  def self.down
    drop_table :phones
  end
end
