class BackfillCurrentRentIncreaseAmounts < ActiveRecord::Migration
  def self.up
    RentalAgreement.find(:all).each do |ra|
      ra.recalculate_rent_increases
    end
  end

  def self.down
  end
end
