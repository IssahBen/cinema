class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :current_bucket, :bucket?
    def current_user
        
        @current_user||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !! current_user 
    end

    def current_bucket 
        @current_bucket||= Bucket.find(session[:bucket_id]) if session[:bucket_id]
    end

    def bucket?
        !! current_bucket

    end

    def require_user 
        if !logged_in? 
            flash[:notice] = "You must be logged in to perform this action"
            redirect_to login_path

        end
    end
    
end
