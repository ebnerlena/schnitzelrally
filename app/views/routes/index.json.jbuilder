# frozen_string_literal: true

json.array! @routes, partial: 'routes/route', as: :route
