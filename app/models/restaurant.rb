class Restaurant < ActiveRecord::Base
  has_many :orders
  has_one :restaurantdetail
  has_many :opentimes, through: :restaurantdetail
  has_many :menusections, through: :restaurantdetail
  has_many :items, through: :restaurantdetail
  has_many :categories, through: :restaurantdetail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :company_name, presence: true
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
end
