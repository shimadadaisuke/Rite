Rails.application.routes.draw do
  # 既存のルートがここにあると仮定

  get '/calendars', to: 'calendars#index'
  get '/reservations/new', to: 'reservations#new', as: 'new_reservation'
  post '/reservations', to: 'reservations#create', as: 'create_reservation'
end
