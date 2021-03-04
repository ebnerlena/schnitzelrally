# frozen_string_literal: true

# routes player association model class
class RoutesPlayersAssociation < ApplicationRecord
  belongs_to :route
  belongs_to :player
end
