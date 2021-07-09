Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create]
      resources :tokens, only: [:create]
      resources :properties, only: [:index, :show]
    end
  end
end
