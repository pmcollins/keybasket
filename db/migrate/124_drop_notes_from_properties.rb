class DropNotesFromProperties < ActiveRecord::Migration
  def self.up
    AddNotesToProperties.down
  end

  def self.down
    AddNotesToProperties.up
  end
end
