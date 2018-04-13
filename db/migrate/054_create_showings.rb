class CreateShowings < ActiveRecord::Migration
  def self.up
    create_table :showings do |t|
      t.column :listing_id, :integer
      t.column :starting_at, :datetime
      t.column :duration_minutes, :integer
      t.column :comments, :text #public
      t.column :notes, :text    #for private use, probably generated after the fact
    end
  end

  def self.down
    drop_table :showings
  end
end
