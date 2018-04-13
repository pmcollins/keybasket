class CreateIncomingMessages < ActiveRecord::Migration
  def self.up
    create_table :incoming_messages do |t|
      t.column :outgoing_message_id, :integer
      t.column :read, :boolean
      t.column :read_on, :date
      t.column :recipient_id, :integer
      t.column :recipient_type, :string
    end
  end

  def self.down
    drop_table :incoming_messages
  end
end
