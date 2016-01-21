class Item < ActiveRecord::Base
  belongs_to :menusection
  belongs_to :restaurantdetail
  has_one :restaurant, through: :restaurantdetail

  validates :name, presence: true
  validates :price, presence: true
  validates :restaurantdetail, presence: true
end
