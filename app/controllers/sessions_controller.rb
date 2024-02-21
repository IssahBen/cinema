class SessionsController < ApplicationController

    def new
         
    end

    def create 
       
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "Login successful"

            redirect_to user
        else
            flash.now[:alert] = "Wrong login credentials"
            render "new"
        end
    end

    def destroy 
        if session[:user_id]
            session[:bucket_id] = nil
            session[:user_id] = nil 

            flash[:notice] =  "logout Successful"
            redirect_to root_path
        else
            render root_path
        end
    end
end
