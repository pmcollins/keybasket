class Showing < ActiveRecord::Base

  belongs_to :listing

  def to_s
    "#{starting_at.month}/#{starting_at.day} Showing"
  end

end
