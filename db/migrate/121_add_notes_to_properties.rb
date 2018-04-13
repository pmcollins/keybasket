class AddNotesToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :notes, :text
  end

  def self.down
    remove_column :properties, :notes
  end
end
