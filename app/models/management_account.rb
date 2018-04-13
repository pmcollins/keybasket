class ManagementAccount

  attr_accessor :company_name

  #company_name
  #password
  #password_confirmation
  #first_name
  #last_name
  #email

  def self.create(p)
    out = nil
    Coordinator.transaction do
      company = Company.create(:name => p[:company_name])
      contact = Contact.create(
        :first_name => p[:first_name],
        :last_name => p[:last_name],
        :email => p[:email]
      )
      login = Login.create(
        :name => p[:email],
        :password => p[:password],
        :password_confirmation => p[:password_confirmation]
      )
      out = Coordinator.create(
        :company_id => company.id,
        :contact_id => contact.id,
        :login_id => login.id
      )
    end
    out
  end

end
