class CreateFees < ActiveRecord::Migration
  def self.up
    create_table :fees do |t|
      t.column :created_on, :date
      t.column :amount, :decimal, :precision => 8, :scale => 2
      t.column :notes, :text
      t.column :rental_agreement_id, :integer
    end
  end

  def self.down
    drop_table :fees
  end
end
