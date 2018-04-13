ActionController::Routing::Routes.draw do |map|
  map.resources :notes
  map.root :controller => 'user_sessions', :action => 'new'
  map.resources :user_sessions
  map.resources :public_listings
  map.resources :management_accounts
  map.resources :photos, :member => {:thumb => :get}
  map.resources :companies do |company|
    company.resources :reports, :member => {:run => :get} do |report|
      report.resources :relation_attributes do |relation_attribute|
        relation_attribute.resources :report_decimal_filters
        relation_attribute.resources :report_integer_filters
        relation_attribute.resources :report_date_filters
        relation_attribute.resources :report_text_filters
        relation_attribute.resources :report_boolean_filters
      end
    end
    company.resources :account_transfers
    company.resources :receivable_rents
    company.resources :company_phones
    company.resources :account_types
    company.resources :company_checks do |company_check|
      company_check.resources :company_check_transactions
    end
    company.resources :accounts do |account|
      account.resources :account_updates
    end
    company.resources :coordinators do |coordinator|
      coordinator.resources :coordinator_phones
      coordinator.resources :coordinator_logins
      coordinator.resources :coordinator_contacts
    end
    company.resources :managers do |manager|
      manager.resources :manager_logins
      manager.resources :manager_purchase_orders
      manager.resources :manager_phones
      manager.resources :manager_contacts
      manager.resources :manager_properties
    end
    company.resources :vendors do |vendor|
      vendor.resources :purchase_orders do |purchase_order|
        purchase_order.resources :purchase_order_approvals
      end
    end
    company.resources :properties, :has_many => [:notes] do |property|
      property.resources :property_reports, :member => {:run => :get}
      property.resources :property_vendors
      property.resources :property_managers
      property.resources :property_accounts
      property.resources :vacancy_notifications
      property.resources :property_phones
      property.resources :building_prototypes
      property.resources :property_photos
      property.resources :property_maintenance_requests do |property_maintenance_request|
        property_maintenance_request.resources :property_maintenance_request_updates
      end
      property.resources :floor_plans do |floor_plan|
        floor_plan.resources :unit_sets
        floor_plan.resources :floor_plan_photos
      end
      property.resources :units, :collection => {:rent_increase_eligible => :get} do |unit|
        unit.resources :move_ins
        unit.resources :unit_photos
        unit.resources :unit_phones
        unit.resources :maintenance_requests do |maintenance_request|
          maintenance_request.resources :maintenance_request_updates
        end
        unit.resources :listings do |listing|
          listing.resources :showings
        end
        unit.resources :rental_agreements do |rental_agreement|
          rental_agreement.resources :rental_agreement_accounts
          rental_agreement.resources :rental_agreement_account_types
          rental_agreement.resources :rental_agreement_account_updates
          rental_agreement.resources :fees
          rental_agreement.resources :leases
          rental_agreement.resources :current_rents
          rental_agreement.resources :moveout_notices
          rental_agreement.resources :move_outs
          rental_agreement.resources :tenants do |tenant|
            tenant.resources :tenant_phones
          end
          rental_agreement.resources :checks do |check|
            check.resources :check_transactions
          end
        end
      end
    end
  end
end
