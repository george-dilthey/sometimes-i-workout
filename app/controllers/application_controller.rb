class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?, :access_token

    def current_user
        if session[:user_id]
            User.find(session[:user_id])
        end
    end

    def logged_in?
        !!current_user
    end

    def access_token
        session[:access_token]
    end

end
