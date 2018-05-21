Rails.application.routes.draw do
  root 'welcome#index'
  get '/register', to: 'users#new'
  get '/dashboard', to: 'dashboard#show'
  get '/activation', to: 'activation#update'
  resources :users, only: %i[create]

  namespace :api do
    namespace :v1 do
      resources :games, only: %i[show create] do
        post '/shots', to: 'games/shots#create'
        post '/ships', to: 'games/ships#create'
      end
    end
  end

end
