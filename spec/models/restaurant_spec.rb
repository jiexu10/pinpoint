require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it { should have_valid(:first_name).when('John', 'Sally') }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when('Smith', 'Swanson') }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:company_name).when('McDonalds', 'Pizza Hut') }
  it { should_not have_valid(:company_name).when(nil, '') }

  it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
  it { should_not have_valid(:email).when(nil, '', 'us', 'us@com', 'us.com') }

  it 'has a matching password confirmation for the password' do
    restaurant = Restaurant.new
    restaurant.password = 'password'
    restaurant.password_confirmation = 'anotherpassword'

    expect(restaurant).to_not be_valid
    expect(restaurant.errors[:password_confirmation]).to_not be_blank
  end

end
