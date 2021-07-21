class User < ApplicationRecord
    has_many :workouts
    has_many :segments, through: :workouts
    
    has_secure_password
    validates :username, :first_name, :last_name, presence: true
    validates :username, uniqueness: true

    def self.find_or_create_from_strava(athlete)
        new_user = find_or_create_by(username: athlete.username ) do |user|
            user.first_name = athlete.firstname
            user.last_name = athlete.lastname
            user.username = athlete.username
            user.password = SecureRandom.hex
            user.id = athlete.id
        end
    end
end
