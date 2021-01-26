Rails.application.routes.draw do
  apipie

  root to: "apipie/apipies#index"
  
  namespace :api do 
    namespace :v1 do
      resources :users do
        collection do
          get 'details'
        end
      end

      resources :sessions do
        collection do
          delete 'invalidate'
          post 'email'
        end
      end

      resources :training_sessions do
        member do
          get 'activities'
        end
        resources :activities, only: [:create]
      end

      resources :activities, only: [:index, :show, :update, :destroy] do
        put 'finish', on: :member

        resources :workout_exercises, only: [:create]
      end

      resources :workout_exercises, only: [:show, :update, :destroy]

      resources :muscle_groups

      post 'account/create', to: 'account#create'
    end
  end
end
