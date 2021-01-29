json.extract! route, :id, :id, :tasks_id, :user_id, :users_id, :latitude, :longitude, :radius, :start_time, :end_time,
              :created_at, :updated_at
json.url route_url(route, format: :json)
