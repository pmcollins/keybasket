class InsertMeasureUnits < ActiveRecord::Migration
  def self.up
    %w(each box foot ounce pound quart ream set hour day month year).each_with_index do |name, i|
      MeasureUnit.create(
        :name => name,
        :ordering => i
      )
    end
  end

  def self.down
    MeasureUnit.delete_all
  end
end
