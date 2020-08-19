class PlanetakinoMovie < ApplicationRecord
  belongs_to :movie, class_name: 'Movie', foreign_key: 'tmdb_fk_id'
end
