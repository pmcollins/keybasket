class UnitSetsController < ApplicationController

  before_filter :manager_authorized?, :find_floor_plan

  def create
    new_set = params[:unit_id] ? params[:unit_id].keys.map{|val| val.to_i} : []
    curr_set = @floor_plan.units.map{|unit| unit.id}
    adds = new_set - curr_set
    deletes = curr_set - new_set
    Unit.find(adds).each do |unit|
      unit.floor_plan = @floor_plan
      unit.save!
    end
    Unit.find(deletes).each do |unit|
      unit.floor_plan = nil
      unit.save!
    end
    redirect_to m([@company, @property, @floor_plan])
  end

end
