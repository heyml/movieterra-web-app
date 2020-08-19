$ ->
  $('.search input').autocomplete
    source: (request, response) ->
      api_key = '00d5f265812d91c1267450ffc85e11f6'
      language = 'ru'
      query = request.term

      $.get '//api.themoviedb.org/3/search/movie', { api_key, language, query }, (data) ->
        response $.map data.results, (item) ->
          {
            label: item.title
            id: item.id
            year: item.release_date
          }
    select: (event, ui) ->
      $.post '/tickets', ticket: movie_id: ui.item.id
        .done ->
          do location.reload

    minLength: 2

  $('.recommend button').on 'click', ->
    do $('.recommendation').show
    do $('.recommend').hide
