# frozen_string_literal: true

json.array! @game_tasks, partial: 'game_tasks/game_task', as: :game_task
