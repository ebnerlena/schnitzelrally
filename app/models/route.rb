# frozen_string_literal: true

# route model class
class Route < ApplicationRecord
  belongs_to :player
  has_many :routes_players_association, dependent: :destroy
  has_many :players, through: :routes_players_association
  has_many :game_tasks, dependent: :destroy
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  validates :name, length: { minimum: 3 }, uniqueness: true
  validates :latitude, :longitude, presence: true

  attr_reader :current_task

  include AASM

  aasm column: :game_state do
    state :planning, initial: true
    state :running
    state :finished

    after_all_transitions :log_status_change

    event :start do
      transitions from: :planning, to: :running
    end

    event :end do
      transitions from: :running, to: :finished
    end
  end

  def log_status_change
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end

  def start
    update(game_state: 'running', start_time: Time.zone.now)
    save!
    @tasks = game_tasks.clone
    @current_task = @tasks.where(state: 'planning').first
    @current_task.start
  end

  def players
    @players = []
    associations = RoutesPlayersAssociation.where(route: self)
    associations.each do |p|
      @players.push(Player.find(p.player_id))
    end
    @players
  end

  def next_task
    players.each(&:next_task)
    @current_task = game_tasks.where(state: 'planning').first
  end

  def end
    players.each(&:finished)
    update(game_state: 'finished', end_time: Time.zone.now)
    save!
  end

  def all_players_ready?
    ready_cnt = 0
    players.each do |p|
      ready_cnt += 1 if p.ready?
    end
    ready_cnt == players.size - 1
  end
end
