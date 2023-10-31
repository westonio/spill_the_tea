Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      resources :subscriptions, only: [:create, :update]
      resources :customers, only: :show do
        resources :subscriptions, only: [:index]
      end
    end
  end
end
