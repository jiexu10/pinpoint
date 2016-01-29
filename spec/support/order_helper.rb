def create_order(cart, driver, restaurant, status, user)
  order = Order.new(cart: cart, driver: driver, restaurant: restaurant,
                    status: status, user: user)
  order.save && cart.update_attributes(status: 'ordered')
  order
end

def create_orders_from_carts(carts, driver)
  status = Status.find_by(name: 'Pending')
  carts.each do |cart|
    cart.restaurant.items.each do |item|
      Cart.add_item(cart, item, '5')
    end
    create_order(cart, driver, cart.restaurant, status, cart.user)
  end
end

def verify_order(order)
  expect(page).to have_content("Order ID: ##{order.id}")
  order.items.each do |item|
    expect(page).to have_content(item.truncate)
    expect(page).to have_content(order.cart.find_quantity(item))
  end
end
