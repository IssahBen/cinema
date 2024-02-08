class BucketsController < ApplicationController
        before_action :require_user, only: [:show]
    def new 
        @bucket=Bucket.new
    end

    def show 
            
           
            
            query= params[:query]
            bucket_id= params[:id]
            session[:bucket_id]= bucket_id
            @user_searched= true if query
            if @user_searched

                search(query)   
            end


            
            
    end

    def update 
        @movie= Movie.new(title: params[:Movie_Name], stream_link: "http://www.omdbapi.com/?apikey=cae79c94&s=#{params[:id]}")
        @movie.bucket=current_bucket
        byebug
        if @movie.save 
            redirect_to current_bucket
        end
    end

    def create 
        bucket=Bucket.new(bucket_params)
        bucket.user=current_user
        if bucket.save 
            flash[:notice]="Bucket Added"
            redirect_to bucket
        else
            render "new"
        end
    end

    def destroy 
      
        if @bucket=Bucket.find_by(id: params[:id])
            @bucket.destroy
        redirect_to user_path(current_user)
        else 
            flash[:notice]="Bucket Deleted successfully"
            redirect_to user_path(current_user)
        end
    end

    private 
    def search(query)
            response= Faraday.new("http://www.omdbapi.com/?apikey=cae79c94&s=#{query}")
            parsed_data = JSON.parse(response.get.body)
            @links=[  ]
            @urls= []
            @type= []
            @title= []
            if parsed_data["Search"] 
                parsed_data["Search"].each do |movie| 
                    @links<< movie["Poster"]
                    @urls << "https://ww4.fmovies.co/search/?q=#{movie["Title"]}"
                    @type << movie["Type"]
                    @title << movie["Title"]
                end 
            end 
    end

    def bucket_params 
        params.require(:bucket).permit(:title,:description)
    end
end

