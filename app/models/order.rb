class Order < ActiveRecord::Base
  has_one :user
  has_one :restaurant
  has_one :cart
  has_many :items, through: :cart

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :status, presence: true
end
