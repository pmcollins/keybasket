class CreateRentalApplications < ActiveRecord::Migration
  def self.up
    create_table :rental_applications do |t|
      t.column :listing_id, :integer
      t.column :created_on, :date
      t.column :fname, :string
      t.column :lname, :string
      t.column :dob, :date
      t.column :drivers_license, :string
      t.column :ssn, :string
      t.column :email, :string
      t.column :home_phone, :string
      t.column :work_phone, :string
      t.column :cell_phone, :string
      t.column :curr_address_line1, :string
      t.column :curr_address_line2, :string
      t.column :curr_city, :string
      t.column :curr_state, :string
      t.column :curr_zip, :string
      t.column :curr_start_date, :date
      t.column :curr_end_date, :date
      t.column :curr_last_rent_paid, :decimal, :precision => 8, :scale => 2
      t.column :curr_reason_for_leaving, :text
      t.column :curr_manager, :string
      t.column :curr_manager_phone, :string
      t.column :prev_address_line1, :string
      t.column :prev_address_line2, :string
      t.column :prev_city, :string
      t.column :prev_state, :string
      t.column :prev_zip, :string
      t.column :prev_start_date, :date
      t.column :prev_end_date, :date
      t.column :prev_last_rent_paid, :decimal, :precision => 8, :scale => 2
      t.column :prev_reason_for_leaving, :text
      t.column :prev_manager, :string
      t.column :prev_manager_phone, :string
      t.column :curr_employer_name, :string
      t.column :curr_employer_address_line1, :string
      t.column :curr_employer_address_line2, :string
      t.column :curr_employer_address_city, :string
      t.column :curr_employer_address_state, :string
      t.column :curr_employer_address_zip, :string
      t.column :curr_employer_occupation, :string
      t.column :curr_employer_business_type, :string
      t.column :curr_employer_supervisor_name, :string
      t.column :curr_employer_start_date, :date
      t.column :curr_employer_end_date, :date
      t.column :curr_employer_monthly_salary, :integer
      t.column :prev_employer_name, :string
      t.column :prev_employer_address_line1, :string
      t.column :prev_employer_address_line2, :string
      t.column :prev_employer_address_city, :string
      t.column :prev_employer_address_state, :string
      t.column :prev_employer_address_zip, :string
      t.column :prev_employer_occupation, :string
      t.column :prev_employer_business_type, :string
      t.column :prev_employer_supervisor_name, :string
      t.column :prev_employer_start_date, :date
      t.column :prev_employer_end_date, :date
      t.column :prev_employer_monthly_salary, :integer
      t.column :occupant1_name, :string
      t.column :occupant1_age, :integer
      t.column :occupant1_relationship, :string
      t.column :occupant2_name, :string
      t.column :occupant2_age, :integer
      t.column :occupant2_relationship, :string
      t.column :occupant3_name, :string
      t.column :occupant3_age, :integer
      t.column :occupant3_relationship, :string
      t.column :occupant4_name, :string
      t.column :occupant4_age, :integer
      t.column :occupant4_relationship, :string
      t.column :unlawful_detainer, :boolean
      t.column :eviction, :boolean
      t.column :bad_credit, :boolean
      t.column :bankruptcy, :boolean
      t.column :felony, :boolean
      t.column :has_pets, :boolean
      t.column :kind_of_pets, :string
      t.column :bank_name, :string
      t.column :bank_branch_address_line1, :string
      t.column :bank_branch_address_line2, :string
      t.column :bank_branch_address_city, :string
      t.column :bank_branch_address_state, :string
      t.column :bank_branch_address_zip, :string
      t.column :bank_checking_account_number, :string
      t.column :bank_checking_balance, :integer
      t.column :bank_savings_account_number, :string
      t.column :bank_savings_balance, :integer
      t.column :credit1_company_name, :string
      t.column :credit1_phone, :string
      t.column :credit1_account_number, :string
      t.column :credit1_balance, :integer
      t.column :credit1_monthly_payment, :integer
      t.column :credit2_company_name, :string
      t.column :credit2_phone, :string
      t.column :credit2_account_number, :string
      t.column :credit2_balance, :integer
      t.column :credit2_monthly_payment, :integer
      t.column :credit3_company_name, :string
      t.column :credit3_phone, :string
      t.column :credit3_account_number, :string
      t.column :credit3_balance, :integer
      t.column :credit3_monthly_payment, :integer
      t.column :credit4_company_name, :string
      t.column :credit4_phone, :string
      t.column :credit4_account_number, :string
      t.column :credit4_balance, :integer
      t.column :credit4_monthly_payment, :integer
    end
  end

  def self.down
    drop_table :rental_applications
  end
end
