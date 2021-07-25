class StaticController < ApplicationController

    def index
        @workouts = Workout.order_by_date.is_public.limit(3)
    end
    
end
