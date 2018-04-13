# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 129) do

  create_table "account_transfers", :force => true do |t|
    t.integer "coordinator_id"
    t.integer "source_account_id"
    t.integer "target_account_id"
    t.decimal "amount"
    t.date    "created_at"
    t.text    "notes"
  end

  create_table "account_types", :force => true do |t|
    t.string  "name",     :null => false
    t.boolean "inverted", :null => false
    t.integer "ordering"
  end

  create_table "account_updates", :force => true do |t|
    t.integer "transfer_id"
    t.string  "transfer_type"
    t.integer "account_id",                                        :null => false
    t.integer "company_id",                                        :null => false
    t.integer "property_id"
    t.integer "unit_id"
    t.integer "rental_agreement_id"
    t.decimal "credit",              :precision => 8, :scale => 2
    t.decimal "debit",               :precision => 8, :scale => 2
    t.date    "created_on"
    t.integer "vendor_id"
  end

  create_table "accounts", :force => true do |t|
    t.string  "name",            :null => false
    t.integer "account_type_id"
  end

  create_table "addresses", :force => true do |t|
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "zip"
  end

  create_table "administrators", :force => true do |t|
    t.integer "login_id"
  end

  create_table "building_prototypes", :force => true do |t|
    t.integer "floors"
    t.integer "units_per_floor"
    t.integer "property_id"
  end

  create_table "check_transactions", :force => true do |t|
    t.integer "check_id"
    t.date    "created_on"
    t.text    "notes"
    t.integer "source_account_id"
    t.integer "target_account_id"
  end

  create_table "checks", :force => true do |t|
    t.integer "rental_agreement_id"
    t.integer "account_id",                                        :null => false
    t.decimal "amount",              :precision => 8, :scale => 2
    t.date    "created_on"
    t.string  "check_number"
    t.date    "nominal_date"
    t.text    "notes"
    t.integer "company_id"
  end

  create_table "companies", :force => true do |t|
    t.string  "name"
    t.integer "address_id"
  end

  create_table "contacts", :force => true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "email"
    t.integer "address_id"
  end

  create_table "coordinators", :force => true do |t|
    t.integer "login_id"
    t.integer "company_id"
    t.integer "contact_id"
  end

  create_table "current_rents", :force => true do |t|
    t.integer "rental_agreement_id"
    t.date    "effective_date"
    t.decimal "amount"
    t.decimal "increase_amount"
  end

  create_table "fees", :force => true do |t|
    t.date    "created_on"
    t.decimal "amount",              :precision => 8, :scale => 2
    t.text    "notes"
    t.integer "rental_agreement_id"
  end

  create_table "floor_plan_photos", :force => true do |t|
    t.integer "floor_plan_id"
    t.integer "photo_id"
    t.text    "caption"
  end

  create_table "floor_plans", :force => true do |t|
    t.string  "name"
    t.integer "property_id"
    t.integer "bedrooms"
    t.integer "bathrooms"
    t.boolean "half_bath"
    t.integer "sq_ft"
    t.text    "description"
    t.decimal "nominal_rent", :precision => 8, :scale => 2
  end

  create_table "floor_plans_vacancy_notifications", :id => false, :force => true do |t|
    t.integer "floor_plan_id",           :null => false
    t.integer "vacancy_notification_id", :null => false
  end

  create_table "incoming_messages", :force => true do |t|
    t.integer "outgoing_message_id"
    t.boolean "read"
    t.date    "read_on"
    t.integer "recipient_id"
    t.string  "recipient_type"
  end

  create_table "leases", :force => true do |t|
    t.date    "start_date"
    t.integer "duration_months"
    t.text    "notes"
    t.integer "rental_agreement_id"
    t.decimal "rent",                :precision => 8, :scale => 2
    t.date    "end_date"
  end

  create_table "listings", :force => true do |t|
    t.integer "unit_id"
    t.integer "lease_months"
    t.date    "listing_date"
    t.date    "available_date"
    t.text    "description"
    t.decimal "rent",           :precision => 8, :scale => 2
  end

  create_table "logins", :force => true do |t|
    t.string "name"
    t.string "hashed_password"
    t.string "salt"
  end

  create_table "maintenance_request_statuses", :force => true do |t|
    t.string  "name"
    t.integer "ordering"
  end

  create_table "maintenance_request_updates", :force => true do |t|
    t.date    "created_at"
    t.text    "notes"
    t.integer "maintenance_request_id"
    t.integer "maintenance_request_status_id"
  end

  create_table "maintenance_requests", :force => true do |t|
    t.text    "description"
    t.integer "unit_id"
    t.integer "property_id"
    t.date    "created_at"
    t.integer "maintenance_request_status_id"
  end

  create_table "manager_properties", :force => true do |t|
    t.integer  "manager_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "managers", :force => true do |t|
    t.integer "company_id"
    t.integer "contact_id"
    t.integer "login_id"
  end

  create_table "measure_units", :force => true do |t|
    t.string  "name"
    t.integer "ordering"
  end

  create_table "move_outs", :force => true do |t|
    t.date    "moved_out_date"
    t.integer "rental_agreement_id"
    t.integer "unit_id"
    t.text    "notes"
  end

  create_table "moveout_notices", :force => true do |t|
    t.date    "notice_date"
    t.date    "moveout_date"
    t.integer "rental_agreement_id"
  end

  create_table "notes", :force => true do |t|
    t.integer  "notable_id"
    t.string   "name"
    t.string   "notable_type"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operators", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "method_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "outgoing_messages" because of following StandardError
#   Unknown type 'data' for column 'attachment'

  create_table "phones", :force => true do |t|
    t.string  "number"
    t.string  "tag"
    t.integer "phoneable_id"
    t.string  "phoneable_type"
  end

  create_table "photos", :force => true do |t|
    t.binary "normalized"
    t.binary "thumb"
    t.date   "date_added"
  end

  create_table "properties", :force => true do |t|
    t.string  "name"
    t.integer "company_id"
    t.integer "address_id"
    t.integer "manager_id"
    t.string  "parking_type"
    t.boolean "has_pool"
    t.text    "ad_text"
    t.integer "property_photo_id"
  end

  create_table "property_photos", :force => true do |t|
    t.integer "property_id"
    t.integer "photo_id"
    t.text    "caption"
  end

  create_table "property_vendors", :force => true do |t|
    t.integer  "property_id"
    t.integer  "vendor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  create_table "public_listings", :force => true do |t|
  end

  create_table "purchase_order_approvals", :force => true do |t|
    t.integer "coordinator_id"
    t.date    "created_at"
    t.text    "notes"
  end

  create_table "purchase_order_line_items", :force => true do |t|
    t.integer "purchase_order_id"
    t.integer "quantity"
    t.string  "product_code"
    t.text    "description"
    t.integer "measure_unit_id"
    t.decimal "unit_price",        :precision => 8, :scale => 2
    t.decimal "total_price",       :precision => 8, :scale => 2
  end

  create_table "purchase_orders", :force => true do |t|
    t.date    "created_at"
    t.date    "required_by"
    t.string  "title"
    t.text    "notes"
    t.integer "payment_term_id"
    t.integer "company_id"
    t.integer "vendor_id"
    t.integer "requisitioner_id"
    t.integer "ship_to_address_id"
    t.decimal "amount"
    t.string  "requisitioner_type"
    t.string  "purchase_order_approval_id"
  end

  create_table "receivable_rents", :force => true do |t|
    t.integer "company_id", :null => false
    t.integer "year",       :null => false
    t.integer "month",      :null => false
    t.date    "created_on"
  end

  create_table "relation_attributes", :force => true do |t|
    t.integer  "relation_id"
    t.string   "name"
    t.string   "attribute_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relation_attributes_reports", :force => true do |t|
    t.integer "report_id"
    t.integer "relation_attribute_id"
  end

  create_table "relations", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.text     "join_condition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rent_payments", :force => true do |t|
    t.date    "created_on"
    t.date    "payed_on"
    t.decimal "amount",              :precision => 8, :scale => 2
    t.integer "rental_agreement_id",                               :null => false
    t.integer "rent_receivable_id"
    t.integer "target_account_id"
    t.text    "notes"
  end

  create_table "rent_receivables", :force => true do |t|
    t.integer "company_id", :null => false
    t.integer "year",       :null => false
    t.integer "month",      :null => false
    t.date    "created_on"
  end

  create_table "rental_agreements", :force => true do |t|
    t.integer "unit_id"
    t.date    "move_in_date"
    t.integer "lease_id"
    t.text    "notes"
    t.decimal "deposit",      :precision => 8, :scale => 2
  end

  create_table "rental_applications", :force => true do |t|
    t.integer "listing_id"
    t.date    "created_on"
    t.string  "fname"
    t.string  "lname"
    t.date    "dob"
    t.string  "drivers_license"
    t.string  "ssn"
    t.string  "email"
    t.string  "home_phone"
    t.string  "work_phone"
    t.string  "cell_phone"
    t.string  "curr_address_line1"
    t.string  "curr_address_line2"
    t.string  "curr_city"
    t.string  "curr_state"
    t.string  "curr_zip"
    t.date    "curr_start_date"
    t.date    "curr_end_date"
    t.decimal "curr_last_rent_paid",           :precision => 8, :scale => 2
    t.text    "curr_reason_for_leaving"
    t.string  "curr_manager"
    t.string  "curr_manager_phone"
    t.string  "prev_address_line1"
    t.string  "prev_address_line2"
    t.string  "prev_city"
    t.string  "prev_state"
    t.string  "prev_zip"
    t.date    "prev_start_date"
    t.date    "prev_end_date"
    t.decimal "prev_last_rent_paid",           :precision => 8, :scale => 2
    t.text    "prev_reason_for_leaving"
    t.string  "prev_manager"
    t.string  "prev_manager_phone"
    t.string  "curr_employer_name"
    t.string  "curr_employer_address_line1"
    t.string  "curr_employer_address_line2"
    t.string  "curr_employer_address_city"
    t.string  "curr_employer_address_state"
    t.string  "curr_employer_address_zip"
    t.string  "curr_employer_occupation"
    t.string  "curr_employer_business_type"
    t.string  "curr_employer_supervisor_name"
    t.date    "curr_employer_start_date"
    t.date    "curr_employer_end_date"
    t.integer "curr_employer_monthly_salary"
    t.string  "prev_employer_name"
    t.string  "prev_employer_address_line1"
    t.string  "prev_employer_address_line2"
    t.string  "prev_employer_address_city"
    t.string  "prev_employer_address_state"
    t.string  "prev_employer_address_zip"
    t.string  "prev_employer_occupation"
    t.string  "prev_employer_business_type"
    t.string  "prev_employer_supervisor_name"
    t.date    "prev_employer_start_date"
    t.date    "prev_employer_end_date"
    t.integer "prev_employer_monthly_salary"
    t.string  "occupant1_name"
    t.integer "occupant1_age"
    t.string  "occupant1_relationship"
    t.string  "occupant2_name"
    t.integer "occupant2_age"
    t.string  "occupant2_relationship"
    t.string  "occupant3_name"
    t.integer "occupant3_age"
    t.string  "occupant3_relationship"
    t.string  "occupant4_name"
    t.integer "occupant4_age"
    t.string  "occupant4_relationship"
    t.boolean "unlawful_detainer"
    t.boolean "eviction"
    t.boolean "bad_credit"
    t.boolean "bankruptcy"
    t.boolean "felony"
    t.boolean "has_pets"
    t.string  "kind_of_pets"
    t.string  "bank_name"
    t.string  "bank_branch_address_line1"
    t.string  "bank_branch_address_line2"
    t.string  "bank_branch_address_city"
    t.string  "bank_branch_address_state"
    t.string  "bank_branch_address_zip"
    t.string  "bank_checking_account_number"
    t.integer "bank_checking_balance"
    t.string  "bank_savings_account_number"
    t.integer "bank_savings_balance"
    t.string  "credit1_company_name"
    t.string  "credit1_phone"
    t.string  "credit1_account_number"
    t.integer "credit1_balance"
    t.integer "credit1_monthly_payment"
    t.string  "credit2_company_name"
    t.string  "credit2_phone"
    t.string  "credit2_account_number"
    t.integer "credit2_balance"
    t.integer "credit2_monthly_payment"
    t.string  "credit3_company_name"
    t.string  "credit3_phone"
    t.string  "credit3_account_number"
    t.integer "credit3_balance"
    t.integer "credit3_monthly_payment"
    t.string  "credit4_company_name"
    t.string  "credit4_phone"
    t.string  "credit4_account_number"
    t.integer "credit4_balance"
    t.integer "credit4_monthly_payment"
  end

  create_table "report_boolean_filters", :force => true do |t|
    t.integer  "report_id"
    t.integer  "relation_attribute_id"
    t.boolean  "search_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_date_filters", :force => true do |t|
    t.string   "search_type"
    t.date     "date1"
    t.date     "date2"
    t.integer  "days_ago1"
    t.integer  "days_ago2"
    t.integer  "operator_id"
    t.integer  "report_id"
    t.integer  "relation_attribute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_decimal_filters", :force => true do |t|
    t.integer  "report_id"
    t.integer  "relation_attribute_id"
    t.decimal  "search_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_integer_filters", :force => true do |t|
    t.integer  "report_id"
    t.integer  "relation_attribute_id"
    t.integer  "search_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_text_filters", :force => true do |t|
    t.string   "search_value"
    t.integer  "report_id"
    t.integer  "relation_attribute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.integer  "company_id"
    t.integer  "owner_id"
    t.string   "name"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "showings", :force => true do |t|
    t.integer  "listing_id"
    t.datetime "starting_at"
    t.integer  "duration_minutes"
    t.text     "comments"
    t.text     "notes"
  end

  create_table "tenants", :force => true do |t|
    t.integer "contact_id"
    t.integer "rental_agreement_id"
  end

  create_table "unit_photos", :force => true do |t|
    t.integer "unit_id"
    t.integer "photo_id"
    t.text    "caption"
  end

  create_table "units", :force => true do |t|
    t.string  "apt"
    t.integer "floor"
    t.integer "property_id"
    t.integer "floor_plan_id"
    t.integer "rental_agreement_id"
    t.text    "notes"
    t.boolean "flagged"
  end

  create_table "user_sessions", :force => true do |t|
    t.integer  "login_id"
    t.datetime "logged_in_at"
    t.datetime "logged_out_at"
    t.text     "remote_ip"
  end

  create_table "vacancy_notifications", :force => true do |t|
    t.integer "contact_id"
    t.integer "property_id"
    t.date    "expires_on"
  end

  create_table "vendors", :force => true do |t|
    t.string  "name"
    t.integer "company_id"
    t.date    "created_on"
  end

end
