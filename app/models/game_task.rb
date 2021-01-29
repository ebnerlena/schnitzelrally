class GameTask < ApplicationRecord
  belongs_to :user
  # belongs_to :route

  validates :name, length: { minimum: 5 }
  validates :description, length: { minimum: 10 }
  validates :hint, length: { minimum: 10 }
end
