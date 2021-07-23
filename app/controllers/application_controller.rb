class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?, :access_token, :require_login, :require_login_and_user

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

    def require_login
        unless logged_in?
            flash[:notices] = ["Whoops! You must be logged in to view that content."]
            redirect_to login_path
        end
    end

    def require_login_and_user
        unless logged_in? && current_user == User.find_by_id(params[:user_id])
            require_login
        end
    end

end
