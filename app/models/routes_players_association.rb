class RoutesPlayersAssociation < ApplicationRecord
  belongs_to :route, :dependent  => :destroy
  belongs_to :player, :dependent  => :destroy
end
