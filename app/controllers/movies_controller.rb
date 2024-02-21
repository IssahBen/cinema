class MoviesController < ApplicationController
    def destroy 
       
        @movie = Movie.find(params[:id])
        @movie.destroy 
         redirect_to bucket_path(current_bucket)

    end
end
