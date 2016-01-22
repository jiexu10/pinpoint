class Cartitem < ActiveRecord::Base
  belongs_to :item
  belongs_to :cart

  validates :item, presence: true
  validates :cart, presence: true
  validates :quantity, presence: true
end
