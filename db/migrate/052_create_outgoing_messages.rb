class CreateOutgoingMessages < ActiveRecord::Migration
  def self.up
    create_table :outgoing_messages do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :attachment, :data
      t.column :created_on, :date
      t.column :sender_id, :integer
      t.column :sender_type, :string
    end
  end

  def self.down
    drop_table :outgoing_messages
  end
end
