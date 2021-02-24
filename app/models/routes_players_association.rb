# frozen_string_literal: true

class RoutesPlayersAssociation < ApplicationRecord
  belongs_to :route
  belongs_to :player
end
