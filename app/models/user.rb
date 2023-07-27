class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  before_create :admin_user
  has_many :reservations
  has_many :services, through: :reservations

  def jwt_payload
    super.merge('name' => name)
  end

  private

  def admin_user
    return unless name == 'admin'

    self.role = 'admin'
  end
end
