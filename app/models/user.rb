# frozen_string_literal: true

# user model class
class User < ApplicationRecord
  # belongs_to :route
  has_one :player, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
