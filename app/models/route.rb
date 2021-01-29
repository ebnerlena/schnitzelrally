class Route < ApplicationRecord
  has_many :game_tasks
  belongs_to :user
  has_many :users
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude
end
