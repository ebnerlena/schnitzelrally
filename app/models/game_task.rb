class GameTask < ApplicationRecord
  belongs_to :player
  belongs_to :route
  has_many_attached :image, dependent: :destroy
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  # validates :name, length: { minimum: 5 }
  # validates :description, length: { minimum: 5 }
  # validates :hint, length: { minimum: 5 }

  def to_s
    "#{type}: #{name}"
  end

  def self.available_types
    [
      { name: 'TextInput', class: TextInput },
      { name: 'PhotoUpload', class: PhotoUpload },
      { name: 'MultipleChoice', class: MultipleChoice },
      { name: 'TrueFalse', class: TrueFalse }
    ]
  end

end
