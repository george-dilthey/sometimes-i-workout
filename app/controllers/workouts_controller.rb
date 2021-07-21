class WorkoutsController < ApplicationController

    before_action :require_login, only: [:new, :create]
    before_action :require_login_and_user, only: [:edit, :update]
    before_action :require_login_if_not_public, only: [:show]
    before_action :set_workout, only: [:show, :edit, :update, :destroy]

    def new
        @workout = Workout.new
        @user = User.find_by_id(params[:user_id])
    end

    def index
        if params[:user_id]
            require_login_and_user
            @user = User.find_by_id(params[:user_id])
            @workouts = @user.workouts
            
        else 
            @workouts = Workout.is_public
        end
    end

    def create
        @workout = current_user.workouts.build(workout_params)
        if @workout.save
            redirect_to user_workouts_path(current_user)
        else
            render :new
        end
    end

    def show
        @segments = @workout.segments
    end

    def edit
    end

    def update
        @workout.update(workout_params)
        redirect_to workout_path        
    end

    def destroy
        @workout.destroy
        @user = current_user
        redirect_to user_workouts_path(@user)
    end


    private

    def workout_params
        params.require(:workout).permit(:name, :date, :type, :distance, :elapsed_time, :public, :segments_attributes => [:name, :distance])
    end

    def set_workout
        @workout = Workout.find_by_id(params[:id])
    end


    def require_login
        unless logged_in?
            flash[:notices] = ["Whoops! You must be logged in to view that content."]
            redirect_to login_path
        end
    end

    def require_login_if_not_public
        @workout = Workout.find_by_id(params[:id])
        unless @workout.public?
            require_login_and_user
        end
    end

    def require_login_and_user
        unless logged_in? && current_user == User.find_by_id(params[:user_id])
            require_login
        end
    end

        
end
