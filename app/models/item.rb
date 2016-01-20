class Item < ActiveRecord::Base
  belongs_to :menusection
  belongs_to :restaurantdetail

  validates :name, presence: true
  validates :price, presence: true
  validates :restaurantdetail, presence: true
end
