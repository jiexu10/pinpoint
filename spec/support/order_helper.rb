def create_order(cart, restaurant, status, user)
  order = Order.new(cart: cart, restaurant: restaurant, status: status, user: user)
  order.save && cart.update_attributes(status: 'ordered')
  order
end

def create_orders_from_carts(carts)
  status = Status.find_by(name: 'Pending')
  carts.each do |cart|
    cart.restaurant.items.each do |item|
      Cart.add_item(cart, item, '5')
    end
    create_order(cart, cart.restaurant, status, cart.user)
  end
end
