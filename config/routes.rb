require 'sidekiq/web'
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[new create show]

      get '/login', to: "users#login"
      get '/auth/github', to: "users#github"
      get '/auth/github/callback', to: "users#github_callback"
      
      mount Sidekiq::Web => '/sidekiq'
    end
  end
end
