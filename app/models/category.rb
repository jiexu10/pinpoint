class Category < ActiveRecord::Base
  has_many :restaurantcategories
  has_many :restaurantdetails, through: :restaurantcategories
  has_many :restaurants, through: :restaurantdetails

  validates :name, presence: true
  validates :str_id, presence: true
end
