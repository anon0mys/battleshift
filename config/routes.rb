Rails.application.routes.draw do
  root 'welcome#index'
  get '/register', to: 'users#new'

  namespace :api do
    namespace :v1 do
      resources :games, only: %i[show] do
        post '/shots', to: 'games/shots#create'
      end
    end
  end

end
