require 'rails_helper'

RSpec.describe User, type: :model, vcr: true do
  it { should have_valid(:first_name).when('John', 'Sally') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Smith', 'Swanson') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:company_name).when('McDonalds', 'Pizza Hut') }

  it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
  it { should_not have_valid(:email).when(nil, '', 'us', 'us@com', 'us.com') }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  it 'finds the right cart for a user' do
    rest = create_restaurant("Boston Beer Garden")
    carts = FactoryGirl.create_list(:cart, 2, restaurant: rest)

    carts.each do |cart|
      expect(cart.user.find_cart(rest)).to eq(cart)
    end
  end
end
