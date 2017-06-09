Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :app do
      namespace :v1 do
        resources :sessions, only: [:create]
        resources :users, only: [:index, :update]
        resources :todos, only: [:create, :update, :destroy] do
          collection do
            resources :complete, only: [:update]
          end
        end
      end
    end
  end
end
