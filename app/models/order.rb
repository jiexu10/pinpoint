class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  belongs_to :cart
  has_many :items, through: :cart
  belongs_to :status
  belongs_to :driver, class_name: 'User'

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :status, presence: true
  validates :cart, presence: true, uniqueness: true
end
