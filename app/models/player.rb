class Player < ApplicationRecord
    belongs_to :user
    has_many :routes, :dependent => :destroy
    has_many :game_tasks, :dependent => :destroy
    has_one_attached :image, :dependent => :destroy

    validates :name, length: { minimum: 3 }
end
