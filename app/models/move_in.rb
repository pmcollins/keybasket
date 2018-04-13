class MoveIn

  def self.create(p)
    RentalAgreement.transaction do
      date = Date.parse(
        p['move_in_date(1i)'] + '-' +
        p['move_in_date(2i)'] + '-' +
        p['move_in_date(3i)']
      )
      @rental_agreement = RentalAgreement.create(
        :unit_id => p[:unit_id],
        :move_in_date => date,
        :deposit => p[:deposit],
        :rent => p[:rent] #causes CurrentRent.create
      )
      unit = Unit.find p[:unit_id]
      unit.rental_agreement_id = @rental_agreement.id
      unit.save!

      fname = p[:first_name]
      lname = p[:last_name]

      t = Tenant.create(
        :fname => fname,
        :lname => lname,
        :rental_agreement_id => @rental_agreement.id
      )
      unless p[:phone].empty?
        o = p[:is_land_line] == '1' ? @rental_agreement.unit : t.contact
        o.phones.create(
          :number => p[:phone],
          :tag => p[:tag]
        )
      end
      if p[:lease_duration].any?
        l = Lease.create(
          :start_date => date,
          :duration_months => p[:lease_duration],
          :rent => p[:rent],
          :rental_agreement_id => @rental_agreement.id
        )
        @rental_agreement.lease = l
        @rental_agreement.save!
      end

      property = unit.property
      company = property.company
      AccountUpdate.transfer_funds(
        :transfer => @rental_agreement,
        :company_id => company.id,
        :property_id => property.id,
        :unit_id => unit.id,
        :rental_agreement_id => @rental_agreement.id,
        :source_account_id => Account.load('security_deposits').id,
        :target_account_id => Account.load('deposits_receivable').id,
        :transfer_amount => p[:deposit]
      )
    end
    @rental_agreement
  end

end
