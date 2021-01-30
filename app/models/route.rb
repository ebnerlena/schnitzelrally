class Route < ApplicationRecord
  has_many :game_tasks
  has_many :players
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude
end
