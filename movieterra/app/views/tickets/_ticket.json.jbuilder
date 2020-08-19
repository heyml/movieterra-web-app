json.extract! ticket, :id, :user_id, :tmdb_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
