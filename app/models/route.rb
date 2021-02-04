class Route < ApplicationRecord
  belongs_to :player
  has_many :players, through: :routes_players_association
  has_many :game_tasks, dependent: :destroy
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  scope :available, -> { where(game_state: 'planning') }

  validates :name, length: { minimum: 5 }, uniqueness: true

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
    # state :saved
  end

  def log_status_change
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end

  def start
    update(game_state: 'running', start_time: Time.zone.now)
    save!
    @tasks = game_tasks.clone
    @current_task = @tasks.first

    # randomize game_task list?
  end

  def next_task(task)
    @current_task = game_tasks.where(state: "planning").first
  end

  def end
    update(game_state: 'finished', end_time: Time.zone.now)
    save!
  end
end
