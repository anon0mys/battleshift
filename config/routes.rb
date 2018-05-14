Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, only: %i[new]

  namespace :api do
    namespace :v1 do
      resources :games, only: %i[show] do
        post '/shots', to: 'games/shots#create'
      end
    end
  end

end
