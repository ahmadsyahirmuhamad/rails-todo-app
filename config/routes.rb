Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      namespace :app do
        resources :sessions, only: [:create]
        # resources :users, only: [:show, :update]
        # resources :todos, only: [:create, :update, :destroy] do
        #   collection do
        #     resources :complete, only: [:update]
        #   end
        # end
      end
    end
  end
end
