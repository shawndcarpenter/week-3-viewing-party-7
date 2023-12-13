Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/movies', to: 'movies#index', as: 'movies'
  get '/movies/:id', to: 'movies#show', as: 'movie'

  # resources :users, only: :show
  get "/dashboard", to: "users#show"

  get '/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  get "/logout", to: "users#logout"
end
