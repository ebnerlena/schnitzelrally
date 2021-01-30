class Player < ApplicationRecord
    belongs_to :route
    belongs_to :user
    has_many :game_tasks
end
