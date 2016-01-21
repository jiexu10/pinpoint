class Restaurantcategory < ActiveRecord::Base
  belongs_to :restaurantdetail
  belongs_to :category

  validates :restaurantdetail, presence: true
  validates :category, presence: true
end
