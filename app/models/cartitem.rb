class Cartitem < ActiveRecord::Base
  belongs_to :item
  belongs_to :cart

  validates :item, presence: true
  validates :cart, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :item, uniqueness: { scope: :cart }

  def pp
    "#{item.truncate}, #{item.price} each (#{quantity})"
  end
end
