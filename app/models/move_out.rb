class MoveOut < ActiveRecord::Base

  #validates_presence_of :rental_agreement_id, :moved_out_date

  belongs_to :rental_agreement
  belongs_to :unit

end
