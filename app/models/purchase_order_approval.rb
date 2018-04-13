class PurchaseOrderApproval < ActiveRecord::Base

  belongs_to :coordinator
  has_one :purchase_order

  #notes, company_id, purchase_order, coordinator_id
  #TODO this is odd; maybe rely on #create and put this in a trigger/callback
  def self.approve(p)
    source_account = Account.load('orders_payable')
    target_account = Account.load('po_expenses')
    poa = PurchaseOrderApproval.create(
      :notes => p[:notes],
      :coordinator_id => p[:coordinator_id]
    )
    po = p[:purchase_order]
    po.purchase_order_approval = poa
    po.save!
    AccountUpdate.transfer_funds(
      :transfer => poa,
      :company_id => p[:company_id],
      :vendor_id => po.vendor_id,
      :source_account_id => source_account.id,
      :target_account_id => target_account.id,
      :transfer_amount => po.amount
    )
  end

end
