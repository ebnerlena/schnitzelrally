class Player < ApplicationRecord
  belongs_to :user
  has_many :routes, through: :routes_players_association
  has_many :game_tasks, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  validates :name, length: { minimum: 3 }
end
