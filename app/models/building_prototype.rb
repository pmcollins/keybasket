class BuildingPrototype

  attr_accessor :floors, :units_per_floor, :property, :type, :starts_with_zero

  def self.types
    %w(alphabetical numbered tens hundreds thousands)
  end

  def initialize(p)
    self.property = p[:property] if p[:property] #may be set via accessor
    self.floors = p[:floors].to_i
    self.units_per_floor = p[:units_per_floor].to_i
    self.type = p[:type]
    self.starts_with_zero = p[:starts_with_zero] #not implemented
  end

  def create_units
    self.floors and self.units_per_floor and self.type or return
    self.class.types.include? self.type || return
    self.send(self.type)
  end

  private

  #begin types

  def alphabetical #a b c d e
    apt = '@' #ie. 'A'.prev
    foreach_unit do |unit, floor|
      apt.next!
    end
  end

  def numbered #1 2 3 4 5
    i = 0
    foreach_unit do |unit, floor|
      i += 1
    end
  end

  def tens #10 11 12 20 21 22
    create_records('%d%01d')
  end

  def hundreds #101 102 103 201 202 203
    create_records('%d%02d')
  end

  def thousands #1001 1002 1003 2001 2002 2003
    create_records('%d%03d')
  end

  #end types

  def create_records(format)
    foreach_unit do |unit, floor|
      sprintf(format, floor, unit)
    end
  end

  def foreach_unit
    p = self.property
    (1..self.floors).each do |floor|
      (1..self.units_per_floor).each do |unit|
        p.units.create(
          :apt => yield(unit, floor),
          :floor => floor
        )
      end
    end
  end

end
