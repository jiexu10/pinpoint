class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  belongs_to :cart
  has_many :items, through: :cart

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :order_status, presence: true
  validates :cart, presence: true, uniqueness: true
end
