json.extract! game_task, :id, :name, :description, :hint, :latitude, :longitude, :user_id, :users_id, :created_at,
              :updated_at
json.url game_task_url(game_task, format: :json)
