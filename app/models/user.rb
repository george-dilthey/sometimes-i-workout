class User < ApplicationRecord
    has_many :workouts
    has_many :segments, through: :workouts
    
    has_secure_password
    validates :email, :first_name, :last_name, presence: true
    validates :email, uniqueness: true

    def self.find_or_create_from_strava(user_info)
        find_or_create_by(id: user_info.id ) do |user|
            user.first_name = user_info.info["first_name"]
            user.last_name = user_info.info["last_name"]
            user.email = user_info.info["email"]
            user.password = SecureRandom.hex
        end
    end
end
