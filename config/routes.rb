Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show]
    end
  end

  # Routes to handle input wrong API endpoints
  get '*path', to: 'application#routing_error'

  root 'home#index'
end
