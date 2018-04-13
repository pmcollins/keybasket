class InsertBasicAccounts < ActiveRecord::Migration

  def self.up
    down
    [ {:name => 'rent_income',          :type => 'income'             },
      {:name => 'fee_income',           :type => 'income'             },
      {:name => 'rents_receivable',     :type => 'accounts_receivable'},
      {:name => 'fees_receivable',      :type => 'accounts_receivable'},
      {:name => 'deposits_receivable',  :type => 'accounts_receivable'},
      {:name => 'security_deposits',    :type => 'liability'          },
      {:name => 'undeposited_funds',    :type => 'bank'               },
      {:name => 'deposited_funds',      :type => 'bank'               }
    ].each do |h|
      Account.create(
        :name => h[:name],
        :account_type_id => AccountType.find(
          :first,
          :conditions => ['name = ?', h[:type]]
        ).id
      )
    end 
  end

  def self.down
    Account.delete_all
  end

end
