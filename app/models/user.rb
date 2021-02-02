class User < ApplicationRecord
  has_many :routes, :dependent => :destroy
  # belongs_to :route
  has_many :game_tasks
  has_one_attached :image, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 3 }
end
