class PagesController < ApplicationController

    def home 
        
        end

        def show 
            query=params[:query]
            response= Faraday.new("http://www.omdbapi.com/?apikey=cae79c94&s=#{query}")
            parsed_data = JSON.parse(response.get.body)
            @links=[ ]
            @urls=[]
            @type=[]
            @title=[]
            parsed_data["Search"].each do |movie| 
                 @links<< movie["Poster"]
                @urls << "https://ww4.fmovies.co/search/?q=#{movie["Title"]}"
                @type << movie["Type"]
                @title << movie["Title"]
        end


            
        

    end
end
