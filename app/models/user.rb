class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ROLES = [
    ['1', 'Customer'],
    ['2', 'Restaurant'],
    ['3', 'Driver']
  ]
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role,
    presence: true,
    inclusion: { in: ROLES.map { |role| role[0] } }
  validate :company_name_for_restaurant
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  def company_name_for_restaurant
    if role == '2' && company_name.blank?
      errors.add(:company_name, "Company name can't be blank for restaurants!")
    end
  end
end
