class PublicListingsController < ApplicationController

  def index
    #@properties = Property.find_with_listings
    @properties = Property.find :all
  end

end
