class User < ActiveRecord::Base
  has_many :carts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, presence: true
  validates :last_name, presence: true
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def find_cart(restaurant)
    carts.detect { |cart| cart.restaurant == restaurant }
  end
end
