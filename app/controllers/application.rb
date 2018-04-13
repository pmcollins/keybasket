class ApplicationController < ActionController::Base

  include ExceptionNotifiable

  session :session_key => 'foo'

  private

  def is_admin?
    not session[:admin_id].blank?
  end

  def is_coordinator?
    not session[:coordinator_id].blank?
  end

  def is_manager?
    not session[:manager_id].blank?
  end

  def company_id_requested
    (params[:controller] == 'companies') ? params[:id] : params[:company_id]
  end
  
  def company_id_requested?
    not company_id_requested.blank?
  end

  def company_matches?
    company_id_requested? and (
      company_id_requested.to_i == session[:company_id]
    )
  end

  def property_id_requested
    (params[:controller] == 'properties') ? params[:id] : params[:property_id]
  end

  def property_id_requested?
    not property_id_requested.blank?
  end

  def property_id_included?
    session[:property_ids].include?(property_id_requested.to_i)
  end

  def property_matches?
    property_id_requested? && property_id_included?
  end

  def is_logged_in?
    not session[:login_id].blank?
  end

  def manager_matches?
    manager_id_requested && (
      manager_id_requested.to_i == session[:manager_id].to_i
    )
  end

  def manager_id_requested
    (params[:controller] == 'managers') ? params[:id] : params[:manager_id]
  end

  def is_company_controller?
    params[:controller] == 'companies'
  end

  def is_manager_authorized?
    return false unless is_logged_in?
    return true if is_coordinator_authorized?
    return true if (
      is_manager? && company_matches? && (
        property_matches? || manager_matches? || is_company_controller?
      )
    )
    return false
  end

  def manager_authorized?
    redirect_unless is_manager_authorized?
  end

  def is_coordinator_authorized?
    return false unless is_logged_in?
    return true if is_admin?
    return true if (is_coordinator? && company_matches?)
    return false
  end

  def coordinator_authorized?
    redirect_unless is_coordinator_authorized?
  end

  def redirect_unless(is_authorized)
    if is_authorized
      return true
    else
      redirect_to '/'
      return false
    end
  end

  #####

  def find_company
    @company_id = params[:company_id]
    redirect_to '/' unless @company_id
    @company = Company.find(@company_id)
  end

  def find_report
    find_company
    @report_id = params[:report_id]
    bail_out unless @report_id
    @report = @company.reports.find(@report_id)
  end

  def find_relation_attribute
    find_report
    @relation_attribute_id = params[:relation_attribute_id]
    bail_out unless @relation_attribute_id
    @relation_attribute = RelationAttribute.find @relation_attribute_id
  end

  def find_company_check
    find_company
    @company_check_id = params[:company_check_id]
    bail_out unless @company_check_id
    @company_check = @company.checks.find(@company_check_id)
  end

  def find_manager
    find_company
    @manager_id = params[:manager_id]
    bail_out unless @manager_id
    @manager = @company.managers.find(@manager_id)
  end

  def find_coordinator
    find_company
    @coordinator_id = params[:coordinator_id]
    bail_out unless @coordinator_id
    @coordinator = @company.coordinators.find(@coordinator_id)
  end

  def find_property
    find_company
    @property_id = params[:property_id]
    bail_out unless @property_id
    @property = @company.properties.find(@property_id)
  end

  def find_vendor
    find_company
    @vendor_id = params[:vendor_id]
    bail_out unless @vendor_id
    @vendor= @company.vendors.find(@vendor_id)
  end

  def find_purchase_order
    find_vendor
    @purchase_order_id = params[:purchase_order_id]
    bail_out unless @purchase_order_id
    @purchase_order = @vendor.purchase_orders.find(@purchase_order_id)
  end

  def find_floor_plan
    find_property
    @floor_plan_id = params[:floor_plan_id]
    bail_out unless @floor_plan_id
    @floor_plan = @property.floor_plans.find(@floor_plan_id)
  end

  def find_unit
    find_property
    @unit_id = params[:unit_id]
    bail_out unless @unit_id
    @unit = @property.units.find(@unit_id)
  end

  def find_listing
    find_unit
    listing_id = params[:listing_id]
    bail_out unless listing_id
    @listing = @unit.listing
    unless (listing_id.to_i == @listing.id)
      bail_out
    end
  end

  def find_rental_agreement
    find_unit
    @rental_agreement_id = params[:rental_agreement_id]
    bail_out unless @rental_agreement_id
    @rental_agreement = @unit.rental_agreement
    unless (@rental_agreement_id.to_i == @rental_agreement.id)
      bail_out
    end
  end

  def find_maintenance_request
    find_unit
    @maintenance_request_id = params[:maintenance_request_id]
    bail_out unless @maintenance_request_id
    @maintenance_request = @unit.maintenance_requests.find(
      @maintenance_request_id
    )
  end

  def find_property_maintenance_request
    find_property
    @property_maintenance_request_id = params[:property_maintenance_request_id]
    bail_out unless @property_maintenance_request_id
    @property_maintenance_request = @property.maintenance_requests.find(
      @property_maintenance_request_id
    )
  end

  def find_tenant
    find_rental_agreement
    @tenant_id = params[:tenant_id]
    bail_out unless @tenant_id
    @tenant = @rental_agreement.tenants.find(@tenant_id)
  end

  def find_check
    find_rental_agreement
    @check_id = params[:check_id]
    bail_out unless @check_id
    @check = @rental_agreement.checks.find(@check_id)
  end

  def find_parent
    self.send("find_#{get_parent_type}")
    set_parent_object
  end

  #redirects

  def to_rental_agreement
    redirect_to m([@company, @property, @unit, @rental_agreement])
  end

  def to_unit
    redirect_to m([@company, @property, @unit])
  end

  def to_tenant
    redirect_to m([@company, @property, @unit, @rental_agreement, @tenant])
  end

  def bail_out
    redirect_to '/'
  end

  #polymorphic resource dryness

  class << self
    attr_reader :parents
    def parent_resources(*parents)
      @parents = parents
    end
  end

  def get_parent_id_by_type(parent_type)
    request.path_parameters["#{parent_type}_id"]
  end

  def get_parent_type
    self.class.parents.detect do |parent_type|
      get_parent_id_by_type(parent_type)
    end
  end
 
  def get_parent_class
    type = get_parent_type or return
    type.to_s.classify.constantize
  end

  def set_parent_object
    klass = get_parent_class or return
    @parent = klass.find(get_parent_id_by_type(get_parent_type))
  end
 
end
