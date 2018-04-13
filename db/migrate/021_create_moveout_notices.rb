class CreateMoveoutNotices < ActiveRecord::Migration
  def self.up
    create_table :moveout_notices do |t|
      t.column :lease_id, :integer
      t.column :notice_date, :date
      t.column :moveout_date, :date
    end
  end

  def self.down
    drop_table :moveout_notices
  end
end
