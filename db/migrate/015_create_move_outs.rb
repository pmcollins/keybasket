class CreateMoveOuts < ActiveRecord::Migration
  def self.up
    create_table :move_outs do |t|
      t.column :unit_id, :integer
      t.column :lease_id, :integer
      t.column :moved_out_date, :date
    end
  end

  def self.down
    drop_table :move_outs
  end
end
