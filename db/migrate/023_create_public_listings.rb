class CreatePublicListings < ActiveRecord::Migration
  def self.up
    create_table :public_listings do |t|
    end
  end

  def self.down
    drop_table :public_listings
  end
end
