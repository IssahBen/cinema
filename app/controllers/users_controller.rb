class UsersController < ApplicationController
   before_action :require_user, only: [:show] 
    def new 
        @user=User.new
    end

    def create 
       
        @user=User.new(user_params)
        if @user.save
            session[:user_id]=@user.id 
            flash[:notice]="You have Successfully signed up"
            redirect_to @user 
        else
            render "new"
        end



    end

    def show
        @redirect_to_page_id= true 
        @bucket=current_user.buckets 
   
        
    end


    def bucket 
     
    end


    private 

    def user_params 
        params.require(:user).permit(:username,:email,:password)
    end
end
