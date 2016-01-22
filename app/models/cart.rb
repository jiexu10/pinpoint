class Cart < ActiveRecord::Base
  has_many :cartitems
  has_many :items, through: :cartitems
  belongs_to :user
  belongs_to :order

  validates :user, presence: true
  validates :restaurant, presence: true
  validates :status, presence: true
end
