class StaticController < ApplicationController

    def index
        @workouts = Workout.order_by_date.limit(3)
    end




end
