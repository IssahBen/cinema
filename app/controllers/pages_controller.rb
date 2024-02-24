class PagesController < ApplicationController

        def home 
            client = Pexels::Client.new('x0mRJ85wb0Yghm7RG1naspIrt27o4JOb1dGlpsnijCAMUaOqM1CpAI0S')
            @urls=[]
            client.photos.search('cinema', per_page: 3).each do |photo|
            @urls << photo.src["original"]
            end
        end

        def show 
            query=params[:query]
            response = Faraday.new("http://www.omdbapi.com/?apikey=cae79c94&s=#{query}")
            parsed_data = JSON.parse(response.get.body)
            @links =[ ]
            @urls = []
            @type = []
            @title = []
           
            if parsed_data["Search"]
                    
                parsed_data["Search"].each do |movie| 
                    @links << movie["Poster"]
                    @urls << "https://fmoviesz.to/filter?keyword=#{movie["Title"]}"
                    @type << movie["Type"]
                    @title << movie["Title"]
                end 
            else 
                render 'home'
            end   
        
        end
end
