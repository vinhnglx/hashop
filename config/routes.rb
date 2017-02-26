Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, except: [:new, :edit, :update, :destroy, :create]
    end
  end
end
