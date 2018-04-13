class PublicListing

  def self.by_property
    listings = Listing.find_all
    listings.group_by do |listing|
      listing.unit.property
    end
  end

end
