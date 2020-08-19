class Movie < ApplicationRecord
  require 'open-uri'

  has_many :tickets
  has_one :planetakino_movie, class_name: 'PlanetakinoMovie', primary_key: 'id', foreign_key: 'tmdb_fk_id'

  def self.fetch(tmdb_id)
    cassette = "#{(tmdb_id / 1000) * 1000}/#{tmdb_id}"
    VCR.use_cassette(cassette) do
      Tmdb::Movie.detail(tmdb_id, language: 'ru')
    end
  rescue => error
    if error.to_s.last(20) == 'allowed limit of 40.'
      sleep 1.second
      retry
    end
  end

  def self.recommendation(*tmdb_ids)
    command = "cd /home/movieterra/env && . /home/movieterra/env/bin/activate && python3 planetakino_recommender.py -l #{tmdb_ids.join(' ')}"
    puts command
    `#{command}`.lines.last.tr('[]', '').split(',').to_a.map(&:to_i) rescue []
  end

  def self.screening
    Rails.cache.fetch('movies', expires_in: 12.hours) do
      xml = Nokogiri::XML(open('https://planetakino.ua/api/movies'))

      xml.search('movie').map do |movie|
        {
          id: movie.at('id').text.to_i,
          poster_url: movie.at('mainPosterUrl').text,
          title: movie.at('name').text,
          description: movie.at('description').text,
          length: movie.at('length').text,
          country: movie.at('country').text,
          genre: movie.at('genre').text,
          trailer: movie.at('youtube-id').text,
          url: movie.at('movieLink').text
        }
      end
    end
  end
end
