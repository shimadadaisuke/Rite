Rails.application.routes.draw do
  # Deviseのルーティング
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations',
    passwords: 'passwords'
  }

  resources :reservations do
    collection do
      get 'confirm'
      post 'confirm', to: 'reservations#create_confirm'
    end
  end
  

  # ユーザー登録と作成のルーティング
  get '/signup', to: 'users#new', as: :new_user
  post '/signup', to: 'users#create', as: :create_user

  # ログインとセッションのルーティング
  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create', as: :create_session
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  # ログインからの受取
  post '/calendars', to: 'calendars#create', as: :create_calendar

  # カレンダーと予約のルーティング
  get '/calendars', to: 'calendars#index', as: :calendars

  # ルートの設定
  root 'sessions#new'

  resources :users
end
