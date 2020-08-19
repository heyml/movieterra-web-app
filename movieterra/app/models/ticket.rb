class Ticket < ApplicationRecord
  belongs_to :user
  #belongs_to :movie
  belongs_to :movie, primary_key: 'tmdb_id', class_name: 'Movie'

  validates :movie_id, uniqueness: { scope: :user }

  def movie_title
    Movie.fetch(movie_id).title
  end

  def poster_url
    poster_path = Movie.fetch(movie_id).poster_path
    poster_path.present? ? "https://image.tmdb.org/t/p/w300/#{poster_path}" : nil
  end
end
