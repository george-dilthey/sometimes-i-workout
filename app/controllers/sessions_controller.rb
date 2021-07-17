class SessionsController < ApplicationController

    def logout
        session.clear
        redirect_to new_user_path
    end

    def login
        render :login
    end

    def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path
        else
            flash [:errors] = ["Invalid email or password!"]
            render login_path
        end
    end

end
