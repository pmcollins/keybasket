class FillLeaseEndDates < ActiveRecord::Migration
  def self.up
    Lease.find(:all).each do |lease|
      lease.set_end_date
      lease.save
    end
  end

  def self.down
    Lease.find(:all).each do |lease|
      lease.end_date = nil
      lease.save
    end
  end
end
