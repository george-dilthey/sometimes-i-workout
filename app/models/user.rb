class User < ApplicationRecord
    has_many :workouts
    has_many :segments, through: :workouts
    
    has_secure_password
    validates :email, :first_name, :last_name, presence: true
    validates :email, uniqueness: true
end
