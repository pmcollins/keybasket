class UnitSet

  attr_accessor :floor_plan_id, :unit_ids

  def initialize(params)
    self.floor_plan_id = params[:floor_plan_id]
    self.unit_ids = params[:unit_ids]
  end

  def update_units
    self.floor_plan_id and self.unit_ids or return
    Unit.find(self.unit_ids).each do |unit|
      unit.floor_plan_id = self.floor_plan_id
      unit.save!
    end
  end

end
