class GameTask < ApplicationRecord
  # belongs_to :player
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  validates :name, length: { minimum: 5 }
  validates :description, length: { minimum: 5 }
  validates :hint, length: { minimum: 3 }

end
