class CreateCurrentRents < ActiveRecord::Migration
  def self.up
    create_table :current_rents do |t|
      t.column :rental_agreement_id, :integer
      t.column :rent, :integer
      t.column :effective_date, :date
    end
  end

  def self.down
    drop_table :current_rents
  end
end
