class BucketsController < ApplicationController
        before_action :require_user, only: [:show]
    def new 
        @bucket = Bucket.new
    end

    def show 
            
           
            
            query = params[:query]
            bucket_id = params[:id]
            session[:bucket_id] = bucket_id
            @user_searched = true if query
            if @user_searched

                search(query)   
            end


            
            
    end

    def update 
        current_bucket.movies.each do |movie|
            if movie.title == params[:title]
                flash.now[:alert] = "Movie Already Added"
                render "show"
            else

                    @movie = Movie.new(title: params[:title], stream_link:  "https://fmoviesz.to/filter?keyword=#{params[:title]}",src: params[:src])
                    @movie.bucket = current_bucket
                
                    if @movie.save 
                        redirect_to current_bucket
                  
                    end
            end
        end 
    end

    def create 
        bucket = Bucket.new(bucket_params)
        bucket.user = current_user
        if bucket.save 
            flash[:notice] = "Bucket Added"
            redirect_to bucket
        else
            render "new"
        end
    end

    def destroy 
      
        if @bucket = Bucket.find_by(id: params[:id])
            @bucket.destroy
        redirect_to user_path(current_user)
        else 
            flash[:notice] = "Bucket Deleted successfully"
            redirect_to user_path(current_user)
        end
    end

   


    private 
    def search(query)
            response = Faraday.new("http://www.omdbapi.com/?apikey=cae79c94&s=#{query}")
            parsed_data = JSON.parse(response.get.body)
            @links=[  ]
            @urls= []
            @type= []
            @title= []
            if parsed_data["Search"] 
                parsed_data["Search"].each do |movie| 
                    @links << movie["Poster"]
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

