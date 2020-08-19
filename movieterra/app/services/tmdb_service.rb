module TmdbService
  extend self

  def movie(id)
    api.detail id
  end

  private

  def api
    Tmdb::Api.key('00d5f265812d91c1267450ffc85e11f6')
  end
end
