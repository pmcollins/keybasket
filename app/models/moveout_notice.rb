class MoveoutNotice < ActiveRecord::Base

  #validates_presence_of :rental_agreement_id, :notice_date, :moveout_date

  belongs_to :rental_agreement

end
