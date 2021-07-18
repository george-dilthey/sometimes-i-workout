class User < ApplicationRecord
    has_many :workouts
    has_many :segments, through: :workouts
    
    has_secure_password
    validates :email, :first_name, :last_name, presence: true
    validates :email, uniqueness: true

    def self.find_or_create_from_strava(user_info)
        new_user = find_or_initialize_by(id: user_info.uid ) do |user|
            user.first_name = user_info.info["first_name"]
            user.last_name = user_info.info["last_name"]
            user.email = user_info.info["email"]
            user.password = SecureRandom.hex
            user.id = user_info.uid
        end
        new_user.save(validate: false)
        new_user
    end
end
