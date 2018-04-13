class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.integer :company_id, :owner_id
      t.string :name, :owner_type
      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
