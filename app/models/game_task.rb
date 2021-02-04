class GameTask < ApplicationRecord
  belongs_to :player
  belongs_to :route
  has_many_attached :images, dependent: :destroy
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  # validates :name, length: { minimum: 5 }
  # validates :description, length: { minimum: 5 }
  # validates :hint, length: { minimum: 5 }

  include AASM

  aasm column: :state do
    state :planning, initial: true
    state :hint
    state :task
    state :answered

    after_all_transitions :log_status_change

    event :start do
      transitions from: :planning, to: :hint
    end

    event :arrived do
      transitions from: :hint, to: :task
    end

    event :completed do
      transitions from: :task, to: :answered
    end
    # state :saved
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

  def completed
    update(state: 'answered')
    save!
  end

  def multiple_choice?
    type == "MultipleChoice"
  end

  def photo_upload?
    type == "PhotoUpload"
  end

  def true_false?
    type == "TrueFalse"
  end

  def text_input?
    type == "TextInput"
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
