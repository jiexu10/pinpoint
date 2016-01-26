class User < ActiveRecord::Base
  has_many :carts
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def find_cart(restaurant)
    carts.detect { |cart| cart.restaurant == restaurant }
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
