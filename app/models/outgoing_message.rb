class OutgoingMessage < ActiveRecord::Base

  has_many :incoming_messages
  belongs_to :sender, :polymorphic => true

end
