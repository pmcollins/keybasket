class PopulatePropertyRelations < ActiveRecord::Migration
  def self.up
    properties = Relation.create(
      :name => 'properties',
      :join_condition => 'units.property_id = properties.id'
    )
    units = properties.children.create(
      :name => 'units',
      :join_condition => 'rental_agreements.unit_id = units.id'
    )
    rental_agreements = units.children.create(
      :name => 'rental_agreements',
      :join_condition => 'tenants.rental_agreement_id = rental_agreements.id'
    )
    tenants = rental_agreements.children.create(
      :name => 'tenants'
    )
  end

  def self.down
    Relation.delete_all
  end
end
