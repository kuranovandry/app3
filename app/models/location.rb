class Location < ActiveRecord::Base
  belongs_to :movie

  geocoded_by :full_street_address
  after_validation :geocode, :if => :address_changed?

  def full_street_address
    "#{address}, #{city}, #{country}"
  end
end
