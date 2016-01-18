class Role < ActiveRecord::Base
  ROLES = ['Customer', 'Restaurant', 'Driver']
  belongs_to :user
  validates :name, presence: true, inclusion: { in: ROLES }
end
