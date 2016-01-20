class Restaurantdetail < ActiveRecord::Base
  belongs_to :restaurant
  has_many :opentimes
  has_many :menusections
  has_many :items
  has_many :restaurantcategories
  has_many :categories, through: :restaurantcategories

  validates :restaurant, presence: true
  validates :name, presence: true
  validates :locuid, presence: true
  validates :phone, presence: true
  validates :address_one, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
end
