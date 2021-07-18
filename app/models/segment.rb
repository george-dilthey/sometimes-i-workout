class Segment < ApplicationRecord
    has_many :users, through: :workouts
    has_and_belongs_to_many :workouts
end
