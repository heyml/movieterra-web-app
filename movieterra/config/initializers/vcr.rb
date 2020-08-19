VCR.configure do |config|
  config.cassette_library_dir = 'cache'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.before_record { |i| i.ignore! if i.response.status.code == 429 }
end
