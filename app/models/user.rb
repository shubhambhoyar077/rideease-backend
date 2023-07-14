class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :validatable, :confirmable,
  :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :reservations
  has_many :services, through: :reservations

  def jwt_payload
    super.merge('name' => self.name)
  end
end
