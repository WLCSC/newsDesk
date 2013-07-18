class ApplicationController < ActionController::Base
    protect_from_forgery

    before_filter :check_for_user

    private
    def current_user  
        @current_user ||= User.find(session[:user_id]) if session[:user_id]  
        @current_user
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def check_for_user
        unless current_user
            redirect_to root_path, :alert => 'Please log in first.'
        end
    end

    def check_for_admin
        unless current_user && current_user.admin?
            redirect_to root_path, :alert => 'You need to be an admin to do that.'
        end
    end

end
