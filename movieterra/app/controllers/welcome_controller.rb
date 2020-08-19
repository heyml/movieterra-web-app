class WelcomeController < ApplicationController
  before_action :auth!, only: [:recommendations, :tickets]

  def index
    @user = current_user
    if current_user.tickets.present?
      #recommendations = PlanetakinoMovie.where(planetakino_id: Movie.recommendation(@user.tickets.pluck(:movie_id))).pluck(:planetakino_id)
      recommendations = Movie.recommendation(@user.tickets.pluck(:movie_id))
      @recommendation = Movie.screening.select { |x| recommendations.include? x[:id] }
    end
  end

  def recommendations
    @user = User.find(params[:user_id])
    recommendations = Movie.recommendation(@user.tickets.pluck(:movie_id))
    @recommendation = Movie.screening.select { |x| recommendations.include? x[:id] }
    render json: {
      movies: @recommendation.pluck(:id)
    }
  end

  def tickets
    user = User.find_or_create_by(id: params[:user_id])
    user.tickets.create(tmdb_id: params[:movie_id]) if params[:movie_id].present?
    render json: {
      movies: user.tickets.pluck(:tmdb_id)
    }
  end

  private

  def auth!
    head :forbidden if params[:access_key] != 'FCRpHzn8PugrkdWEHStNQDZh'
  end
end
