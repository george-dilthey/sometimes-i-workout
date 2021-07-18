class Segment < ApplicationRecord
    has_and_belongs_to_many :workouts
    has_many :users, through: :workouts
end
