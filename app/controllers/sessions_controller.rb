class SessionsController < ApplicationController

    def logout
        session.clear
        redirect_to login_path
    end

    def login
    end

    def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to user_workouts_path(user)
        else
            flash[:notices] = ["Invalid email or password!"]
            redirect_to login_path
        end
    end

    def strava_omniauth
        user_info = request.env["omniauth.auth"]
        client = StravaApi.new(user_info)
        user = client.user
        if user
            session[:user_id] = user.id
            client.create_workouts
            client.create_segments
            redirect_to user_workouts_path(user)
        else
            flash[:errors] = user.errors.full_messages
            redirect_to login_path
        end
    end

end
