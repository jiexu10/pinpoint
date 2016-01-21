class Category < ActiveRecord::Base
  has_many :restaurantcategories
  has_many :restaurantdetails, through: :restaurantcategories

  validates :name, presence: true
  validates :str_id, presence: true
end
