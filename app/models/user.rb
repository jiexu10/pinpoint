class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :role

  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :role_exists
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def role_exists
    errors.add(:role, "That user type does not exist") if (role.name rescue NoMethodError) == NoMethodError
  end
end
