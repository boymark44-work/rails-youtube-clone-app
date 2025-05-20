Rails.application.routes.draw do
  # The Root Path
  root 'posts#index'

  # Download Video Route
  get 'posts/:id/download', to: 'posts#download', as: 'download_post' # Download video route

  # My Videos Route
  get 'pages/media' 

  # Resource and routes for Videos
  resources :posts do 
    resource :like, only: [:create, :destroy] # Singular resource because one like per user per post
    resources :comments # CRUD routes for Comments
  end
  
  # Notifications
  resources :notifications, only: [:index, :update] do 
    collection do 
      patch :mark_all_read # This defines a collection route (no :id required) for PATCH requests
    end
  end
  
  # User Authentication using Devise Gem
  devise_for :users

  # Update User Profile Route 
  resource :profile, only: [:edit, :update]

  # Routes for Admin 
  namespace :admin do 
    resources :users, only: [:index, :edit, :update, :destroy] do 
      # Adding a nested routes for creating notes under users
      resources :notes, only: [:new, :create]
    end

    resources :authors, only: [:index] do 
      resources :notes, controller: "author_notes", only: [:new, :create]
    end
  end

  # Routes for Notes 
  resources :notes, only: [:index]

  # Devise Routes for Authors
  devise_for :authors

  # Routes for Authors
  namespace :authors do
    resources :blogs

    resources :notifications, only: [:index, :update] do 
      collection do 
        patch :mark_all_as_read
      end
    end

    resources :notes, only: [:index]
  end

  #resources :blogs, only: [:index, :show] # This is for the Public Blogs View

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
