class Cartitem < ActiveRecord::Base
  belongs_to :item
  belongs_to :cart

  validates :item, presence: true
  validates :cart, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }

  def pretty_print
    "#{item.name}, #{item.price} each (#{quantity})"
  end
end
