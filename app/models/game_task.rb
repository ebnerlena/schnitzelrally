class GameTask < ApplicationRecord
  belongs_to :user
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  validates :name, length: { minimum: 5 }
  validates :description, length: { minimum: 10 }
  validates :hint, length: { minimum: 10 }
end
