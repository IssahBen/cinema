# frozen_string_literal: true

class BucketsController < ApplicationController
  before_action :require_user, only: [:show]
  def show
    query = params[:query]
    bucket_id = params[:id]
    session[:bucket_id] = bucket_id
    @user_searched = true if query
    return unless @user_searched

    search(query)
  end

  def new
    @bucket = Bucket.new
  end

  def create
    bucket = Bucket.new(bucket_params)
    bucket.user = current_user
    if bucket.save
      flash[:notice] = 'Bucket Added'
      redirect_to bucket
    else
      render 'new'
    end
  end

  def update
    current_bucket.movies.each do |movie|
      if movie.title == params[:title]
        flash.now[:alert] = 'Movie Already Added'
        render 'show'
      else

        @movie = Movie.new(title: params[:title],
                           stream_link: "https://fmoviesz.to/filter?keyword=#{params[:title]}", src: params[:src])
        @movie.bucket = current_bucket

        redirect_to current_bucket if @movie.save
      end
    end
  end

  def destroy
    if (@bucket = Bucket.find_by(id: params[:id]))
      @bucket.destroy
    else
      flash[:notice] = 'Bucket Deleted successfully'
    end
    redirect_to user_path(current_user)
  end

  private

  def search(query)
    response = Faraday.new("http://www.omdbapi.com/?apikey=#{ENV.fetch('API_KEY', nil)}&s=#{query}")
    parsed_data = JSON.parse(response.get.body)
    @links = []
    @urls = []
    @type = []
    @title = []
    return unless parsed_data['Search']

    parsed_data['Search'].each do |movie|
      @links << movie['Poster']
      @urls << "https://ww4.fmovies.co/search/?q=#{movie['Title']}"
      @type << movie['Type']
      @title << movie['Title']
    end
  end

  def bucket_params
    params.require(:bucket).permit(:title, :description)
  end
end
