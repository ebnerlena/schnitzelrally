class Route < ApplicationRecord
  has_many :game_tasks
  belongs_to :user
  has_many :users
end
