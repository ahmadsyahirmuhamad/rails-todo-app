Rails.application.routes.draw do

  root to: 'pages#index'


  namespace :api, defaults: { format: 'json' } do
    namespace :app do
      namespace :v1 do
        resources :sessions, only: [:create]
        resources :register, only: [:create]
        resources :users, only: [:index, :update]
        resources :todos, only: [:index, :create, :update, :destroy] do
          collection do
            resources :complete, only: [:update]
          end
        end
      end
    end
  end
end
