class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :notable_id
      t.string :name, :notable_type
      t.text :value
      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
