class Menusection < ActiveRecord::Base
  belongs_to :restaurantdetail
  has_many :items

  validates :name, presence: true
  validates :restaurantdetail, presence: true
end
