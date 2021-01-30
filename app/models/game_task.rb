class GameTask < ApplicationRecord
  belongs_to :player
  belongs_to :route
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  validates :name, length: { minimum: 5 }
  validates :description, length: { minimum: 10 }
  validates :hint, length: { minimum: 10 }
end
