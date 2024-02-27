class PagesController < ApplicationController
  def home; end

  def show
    query = params[:query]
    response = Faraday.new("http://www.omdbapi.com/?apikey=#{ENV.fetch('API_KEY', nil)}&s=#{query}")
    parsed_data = JSON.parse(response.get.body)
    @links = []
    @urls = []
    @type = []
    @title = []

    if parsed_data['Search']

      parsed_data['Search'].each do |movie|
        @links << movie['Poster']
        @urls << "https://fmoviesz.to/filter?keyword=#{movie['Title']}"
        @type << movie['Type']
        @title << movie['Title']
      end
    else
      render 'home'
    end
  end
end
