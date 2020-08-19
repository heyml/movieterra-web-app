namespace :tmdb do
  task :sync => :environment do
    from = Dir.entries("cache/#{Dir.entries('cache').map(&:to_i).max}").max.to_i rescue 1
    to = Tmdb::Movie.latest.id

    progressbar = ProgressBar.create(total: to - from, format: "\t%c of %C %P%% %e")

    (from..to).each do |tmdb_id|
      progressbar.increment

      begin
        cassette = "#{(tmdb_id / 1000) * 1000}/#{tmdb_id}"
        VCR.use_cassette(cassette, record: :new_episodes) do
          movie = Tmdb::Movie.detail(tmdb_id, language: 'ru')
          # puts "#{tmdb_id} #{movie.title}"
        end
      rescue => error
        if error.to_s.last(19) != 'could not be found.'
          puts "#{tmdb_id} #{error}"
          sleep 1.second
          retry
        end
      end
    end
  end
end
