class Route < ApplicationRecord
  belongs_to :player
  has_many :players
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

  # def initialize
  #   @current_task_index = 0
  #   @tasks = []

  #   #game_id = random string
  # end

  def log_status_change
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end

  def start
    update(game_state: 'running')
    save!
    @tasks = game_tasks.clone
    @current_task = @tasks.first
  end

  def join(user)
    user.ro
    save!
  end

  def next_task
    @tasks.drop(1)
    @current_task = @tasks.first
  end
end
