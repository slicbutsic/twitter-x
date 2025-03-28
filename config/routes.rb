Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    member do
      get 'followers'
      get 'following'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
  resources :posts do
    resources :comments
    resources :likes
  end

  # resources :follows, only: [:create, :destroy]
  post '/follow/:following_id', to: 'follows#create', as: :follow
  delete '/unfollow/:id', to: 'follows#destroy', as: :unfollow
end
