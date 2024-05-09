class Location < ApplicationRecord
    validates :name, :address , presence: true
    validates :address, uniqueness: true

    geocoded_by :address, units: :km
    after_validation :geocode
end
