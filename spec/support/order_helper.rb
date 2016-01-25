def create_order(cart, restaurant, user)
  order = Order.new(cart: cart, restaurant: restaurant, user: user)
  order.save && cart.update_attributes(status: 'ordered')
  order
end
