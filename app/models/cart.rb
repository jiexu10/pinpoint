class Cart < ActiveRecord::Base
  has_many :cartitems
  has_many :items, through: :cartitems
  belongs_to :user
  belongs_to :order

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :status, presence: true

  def self.add_item(cart, item, quantity)
    Cartitem.find_or_create_by(cart: cart, item: item) do |ci|
      ci.quantity = quantity
    end
  end

  def find_total
    cartitems.each do |cartitem|
      cartitem.item.price.to_f * cartitem.quantity
end
