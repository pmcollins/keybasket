class AccountTransfer < ActiveRecord::Base

  belongs_to(
    :source_account,
    :class_name => 'Account',
    :foreign_key => 'source_account_id'
  )
  belongs_to(
    :target_account,
    :class_name => 'Account',
    :foreign_key => 'target_account_id'
  )
  belongs_to(:coordinator)

end
