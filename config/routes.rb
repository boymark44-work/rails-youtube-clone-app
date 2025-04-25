Rails.application.routes.draw do
  # Devise for Users
  devise_for :users

  # Resource and routes for Videos
  resources :posts do 
    resource :like, only: [:create, :destroy] # Singular resource because one like per user per post
  end
  
  get 'pages/media' # My videos route
  get 'posts/:id/download', to: 'posts#download', as: 'download_post' # Download video route

  # The Root Path
  root "posts#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
