class Opentime < ActiveRecord::Base
  belongs_to :restaurantdetail

  validates :restaurantdetail, presence: true
  validates :day, presence: true
  validates :hours, presence: true
end
