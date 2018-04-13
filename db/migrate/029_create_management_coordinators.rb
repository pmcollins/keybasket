class CreateManagementCoordinators < ActiveRecord::Migration
  def self.up
    create_table :management_coordinators do |t|
      t.column :user_id, :integer
      t.column :company_id, :integer
      t.column :user, :integer
    end
  end

  def self.down
    drop_table :management_coordinators
  end
end
