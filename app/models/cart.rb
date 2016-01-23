class Cart < ActiveRecord::Base
  has_many :cartitems
  has_many :items, through: :cartitems
  belongs_to :user
  belongs_to :restaurant
  belongs_to :order
  accepts_nested_attributes_for :cartitems, reject_if: :reject_cartitems?

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :status, presence: true
  validates :user, uniqueness: { scope: [:restaurant, :status] }

  def find_quantity(item)
    target_item = cartitems.detect { |ci| ci.item == item }
    target_item.quantity
  end

  def find_total
    total_price = 0.00
    cartitems.each do |cartitem|
      total_price += cartitem.item.price.to_f * cartitem.quantity.to_f
    end
    total_price.round(2)
  end

  def reject_cartitems?(attributed)
    quantity = attributed['quantity']
    quantity.blank? || quantity.match(/^\d+$/)
  end

  def self.add_item(cart, item, quantity)
    Cartitem.find_or_create_by(cart: cart, item: item) do |ci|
      ci.quantity = quantity
    end
  end
end
