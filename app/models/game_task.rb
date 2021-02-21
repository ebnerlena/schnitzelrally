class GameTask < ApplicationRecord
  belongs_to :player
  belongs_to :route
  has_many_attached :images, dependent: :destroy
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  # not using cause of empty creating of gametask when choosing format
  # validates :name, length: { minimum: 3 }
  # validates :description, length: { minimum: 5 }
  # validates :hint, length: { minimum: 5 }

  include AASM

  aasm column: :state do
    state :planning, initial: true
    state :hint
    state :task
    state :waiting_for_answers
    state :answered

    after_all_transitions :log_status_change

    event :start do
      transitions from: :planning, to: :hint
    end

    event :arrived do
      transitions from: :hint, to: :task
    end

    event :answering do
      transitions from: :task, to: :waiting_for_answers
    end

    event :completed do
      transitions from: :waiting_for_answers, to: :answered
    end
  end

  def to_s
    "#{type}: #{name}"
  end

  def start
    update(state: 'hint')
    save!
  end

  def arrived
    update(state: 'task')
    save!
  end

  def answering
    update(state: 'waiting_for_answers')
    save!
  end

  def all_answered?
    players = route.players
    unless answers.nil?
      players.size == if multiple_choice?
                        (answers.size - 1)
                      else
                        answers.size
                      end
    end
  end

  def completed
    update(state: 'answered')
    save!
  end

  def player_has_answered(player)
    unless answers.nil?
      if answers.include?(player.id.to_s)
        answering
      else
        arrived
      end
    end
  end

  def correct_answers
    cnt = 0
    answers.each_value do | value |
      if value == solution
        cnt = cnt+1
      end
    end
    cnt
  end

  def multiple_choice?
    type == 'MultipleChoice'
  end

  def photo_upload?
    type == 'PhotoUpload'
  end

  def true_false?
    type == 'TrueFalse'
  end

  def text_input?
    type == 'TextInput'
  end

  def self.available_types
    [
      { name: 'TextInput', class: TextInput },
      { name: 'PhotoUpload', class: PhotoUpload },
      { name: 'MultipleChoice', class: MultipleChoice },
      { name: 'TrueFalse', class: TrueFalse }
    ]
  end

  def log_status_change
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end
end
