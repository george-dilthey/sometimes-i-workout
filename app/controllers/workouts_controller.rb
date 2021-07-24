class WorkoutsController < ApplicationController

    before_action :require_login, only: [:new, :create]
    before_action :require_login_and_user, only: [:edit]
    before_action :set_workout, only: [:show, :edit, :update, :destroy]

    def new
        @workout = Workout.new
        @user = User.find_by_id(params[:user_id])
    end

    def index
        @params = params.permit(:search).to_h
        if params[:user_id]
            require_login_and_user
            @user = User.find_by_id(params[:user_id])
            @workouts = @user.workouts.order_by_date.search(params[:search])
            render :user_index 
        else
            @workouts = order_workout_by.is_public.search(params[:search])
            puts params
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
        unless @workout.public
            require_login_and_user
        end
        @segments = @workout.segments
    end

    def edit
    end

    def update
        if params[:stars]
            @workout.add_star
            @workout.save
            redirect_to workouts_path
        else
            @workout.update(workout_params)
            redirect_to workout_path 
        end       
    end

    def destroy
        @workout.destroy
        @user = current_user
        redirect_to user_workouts_path(@user)
    end

    private

    def workout_params
        params.require(:workout).permit(:name, :date, :type, :distance, :elapsed_time, :public, :order_by, :segments_attributes => [:name, :distance])
    end

    def set_workout
        @workout = Workout.find_by_id(params[:id])
    end

    def order_workout_by
        params[:order_by] == "stars" ? Workout.order_by_stars : Workout.order_by_date
    end
      
end
