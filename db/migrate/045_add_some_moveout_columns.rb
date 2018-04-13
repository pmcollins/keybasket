class AddSomeMoveoutColumns < ActiveRecord::Migration
  def self.up
    add_column :move_outs, :unit_id, :integer
    add_column :move_outs, :notes, :text
  end

  def self.down
    remove_column :move_outs, :unit_id
    remove_column :move_outs, :notes
  end
end
