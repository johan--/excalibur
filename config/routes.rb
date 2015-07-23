require 'api_constraints'
require 'subdomain'

Fustal::Application.routes.draw do
  apipie
  mount Judge::Engine => '/judge'  
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
    end
  end 
  constraints :subdomain => 'blog' do
    get '' => "pages#posts"
    get "posts/:id", to: "pages#show_post", as: "post"
    get "posts/find", to: "pages#find_posts", as: "find_posts"
  end

# New App
  resources :teams
  resources :businesses, controller: 'teams', type: 'Business' 
  resources :financiers, controller: 'teams', type: 'Agency' 
  resources :profiles
  resources :user_profiles, controller: 'profiles', type: 'UserProfile' 
  resources :company_profiles, controller: 'profiles', type: 'CompanyProfile'
  resources :bids
  resources :tenders

  resources :relationships, only: [:create, :destroy]

  # Static Pages
  root "pages#landing"
  get "home", to: "pages#home", as: :user_root
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  
  namespace :admin do
    root "base#index"
    resources :users
    resources :firms, only: [:index]
    resources :reservations, only: [:index]
    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    get "posts/dashboard", to: "posts#dashboard", as: "posts_dashboard"
    resources :posts
  end

  namespace :biz do
    root "base#show"
    get "profile", to: "base#profile", as: :profile
    post "subscribes", to: "base#subscribes", as: :subscribes
    get "management", to: "base#management", as: :management
    get "settings", to: "base#settings", as: :settings
    put "save_settings", to: "base#save_settings", as: :save_settings
    
    get "view", to: "base#view", as: :view
    put "confirm" => "base#confirm", as: :confirm
    
    get "edit_bio", to: "base#edit_bio", as: :edit_bio
    put "update_bio", to: "base#update_bio", as: :update_bio
    resources :rosters

    get "subscription", to: "base#subscription", as: :subscription
    get "expiration", to: "base#expiration", as: :expiration
    
    get "contact", to: "base#contact", as: "contact"
  end

end
