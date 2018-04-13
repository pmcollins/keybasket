class IncomingMessage < ActiveRecord::Base

  belongs_to :outgoing_message
  belongs_to :recipient, :polymorphic => true

end
