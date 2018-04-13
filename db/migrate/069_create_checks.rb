class CreateChecks < ActiveRecord::Migration
  def self.up
    create_table :checks do |t|
      t.column :rental_agreement_id, :integer
      t.column :account_id, :integer, :null => false
      t.column :amount, :decimal, :precision => 8, :scale => 2
      t.column :created_on, :date
      t.column :check_number, :string
      t.column :nominal_date, :date
      t.column :notes, :text
    end
  end

  def self.down
    drop_table :checks
  end
end
