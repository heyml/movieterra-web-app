class MoviesController < ApplicationController
  def search
    movies = Tmdb::Search.movie(params[:title], language: 'ru').results.map do |movie|
      {
        id: movie.id,
        title: movie.title,
        year: movie.release_date
      }
    end

    render json: movies
  end
end
