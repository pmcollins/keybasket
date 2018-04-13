class RenameMcFkCols < ActiveRecord::Migration
  def self.up
    ['purchase_order_approvals', 'account_transfers'].each do |table|
      rename_column(
        table,
        'management_coordinator_id',
        'coordinator_id'
      )
    end
  end

  def self.down
    ['purchase_order_approvals', 'account_transfers'].each do |table|
      rename_column(
        table,
        'coordinator_id',
        'management_coordinator_id'
      )
    end
  end
end
