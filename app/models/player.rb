class Player < ApplicationRecord
  belongs_to :user
  has_many :routes_players_association, dependent: :destroy
  has_many :routes, through: :routes_players_association, dependent: :destroy
  has_many :game_tasks, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  validates :name, length: { minimum: 3 }

  include AASM

  aasm column: :state do
    state :planning, initial: true
    state :ready
    state :searching
    state :answering
    state :answered
    state :completed

    after_all_transitions :log_status_change

    event :finished_planning do
      transitions from: :planning, to: :ready
    end

    event :route_start do
      transitions from: :ready, to: :searching
    end

    event :found do
      transitions from: :searching, to: :answering
    end

    event :next_task do
      transitions from: :answering, to: :searching
    end

    event :answer do
      transitions from: :answering, to: :answered
    end

    event :finished do
      transitions from: :answering, to: :completed
    end
  end

  def routes
    @routes = []
    associations = RoutesPlayersAssociation.where(player: self)
    associations.each do |r|
      @routes.push(Route.find(r.route_id))
    end
    @routes
  end

  def route_start
    update(state: 'searching')
    save!
  end

  def planning
    update(state: 'planning')
    save!
  end

  def found
    update(state: 'answering')
    save!
  end

  def next_task
    update(state: 'searching')
    save!
  end

  def answer
    update(state: 'answered')
    save!
  end

  def finished
    update(state: 'completed')
    save!
  end
end
