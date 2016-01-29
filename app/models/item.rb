class Item < ActiveRecord::Base
  has_many :cartitems
  has_many :carts, through: :cartitems
  belongs_to :menusection
  belongs_to :restaurantdetail
  has_one :restaurant, through: :restaurantdetail

  validates :name, presence: true
  validates :price, presence: true
  validates :restaurantdetail, presence: true

  def truncate
    trunc = name.length > 20 ? name[0..20] + '...' : name
  end
end
