class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  has_many :alerts
  has_many :matches, through: :products
  validates :phone_number, uniqueness: true
  validates :discord_username, uniqueness: true
end
