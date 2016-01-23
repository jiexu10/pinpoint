require 'rails_helper'

feature 'user creates an order via cart', %{
  As a customer
  I want to create an order
  So that I can finalize the food that I want
}, vcr: true, focus: true do

  # Acceptance Criteria:
  # - [ ] I should see a link to place the order
  # - [ ] I should have a confirmation to place the order
  # - [ ] If an order is not confirmed, it should not be completed

  scenario 'user has a cart and places an order'
end
