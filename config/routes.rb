Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show]
      resources :tokens, only: [:create]
      resources :properties, only: [:index, :show, :create, :update, :destroy]
      resources :favorites, only: [:index, :create]
    end
  end
end
