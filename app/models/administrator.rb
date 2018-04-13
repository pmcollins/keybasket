class Administrator < ActiveRecord::Base

  belongs_to :login

  has_many :outgoing_messages, :as => :sender

end
