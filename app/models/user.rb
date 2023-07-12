class User < ApplicationRecord
  has_many :reservations
  has_many :services, through: :reservations
end
