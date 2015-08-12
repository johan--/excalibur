require 'api_constraints'
require 'subdomain'

Fustal::Application.routes.draw do
  apipie
  mount Attachinary::Engine => "/attachinary"
  mount Ckeditor::Engine => '/ckeditor'
  
  devise_for :users, :controllers => { :registrations => "registrations", 
                            :omniauth_callbacks => "omniauth_callbacks" }

  # namespace :api, :path => '/', constraints: { subdomain: 'api' },  defaults: { format: :json }  do  
  namespace :api,  defaults: { format: :json }  do  
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:index, :show, :create, :update]
      resources :sessions, only: [:create, :destroy]
      resources :relationships, only: [:index, :show, :create, :destroy]
      resources :businesses, only: [:index, :show, :create, :update, :destroy]
      resources :tenders, only: [:index, :show, :create, :update, :destroy]
      resources :bids, only: [:index, :show, :create, :update, :destroy]
      resources :rosters, only: [:show, :create, :update, :destroy]
    end
  end

  namespace :blog, path: '/', constraints: { subdomain: 'blog' } do
    get "find", to: "posts#find_posts", as: "find_posts"
    resources :posts do
      resources :comments, only: [:new, :edit, :create, :update, :destroy]
    end
    get '' => "posts#index"
  end

# New App
  resources :users, only: [:show, :edit, :update] do
    resources :tenders, only: [:new, :edit, :create, :update, :destroy]
  end
  resources :teams
  resources :businesses do
    resources :tenders, only: [:new, :edit, :create, :update, :destroy]
  end
  resources :tenders, only: [:show] do
    resources :bids
  end

  # Static Pages
  root "pages#landing"
  get "home", to: "pages#home", as: :user_root
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  post "/subscribe", to: "pages#subscribe", as: "subscribe"
  
  get "/404" => "errors#not_found"
  get "/422" => "errors#unprocessable"
  get "/500" => "errors#internal_server_error"

  namespace :admin do
    root "base#index"
    get 'analytics', to: "base#analytics", as: :analytics
    get 'inbox', to: "base#inbox", as: :inbox
    resources :users
    resources :teams, only: [:index, :show, :destroy]
    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    resources :posts
  end

  namespace :enterprise do
    root "base#show"
    # get "profile", to: "base#profile", as: :profile
    # post "subscribes", to: "base#subscribes", as: :subscribes
    # get "management", to: "base#management", as: :management
    # get "settings", to: "base#settings", as: :settings
    # put "save_settings", to: "base#save_settings", as: :save_settings
    
    # get "view", to: "base#view", as: :view
    # put "confirm" => "base#confirm", as: :confirm
    
    # get "edit_bio", to: "base#edit_bio", as: :edit_bio
    # put "update_bio", to: "base#update_bio", as: :update_bio
    # resources :rosters

    # get "subscription", to: "base#subscription", as: :subscription
    # get "expiration", to: "base#expiration", as: :expiration
    
    # get "contact", to: "base#contact", as: "contact"
  end

end