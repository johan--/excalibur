require 'api_constraints'
require 'subdomain'

Fustal::Application.routes.draw do
  wiki_root '/wiki'

  mount Attachinary::Engine => "/attachinary"

  devise_for :users, :controllers => { 
    :registrations => "registrations", :sessions => "sessions", 
    :passwords => "passwords", :omniauth_callbacks => "omniauth_callbacks" 
  }

  namespace :blog, path: '/blog' do
    get "find", to: "posts#find_posts", as: "find_posts"
    get "diskusi", to: "posts#discussion_room", as: "discussion"
    resources :posts do
    end
    get '' => "posts#index"
  end

# New App
  resources :users, only: [:show, :edit, :update] do
    member do
      get "avatar"
      put "remove_avatar"
    end    
  end

  scope module: 'trading' do
    resources :tenders do
      member do
        get "discuss"
      end
      resources :bids
    end
  end

  resources :documents
  resources :houses do
    resources :steps, only: [:show, :update], controller: 'houses/steps'
    resources :tenders, only: [:new, :create], controller: 'trading/tenders'
  end
  resources :comments
  # resources :invoices do
  #   resources :payments
  # end

  # Static Pages
  # root "pages#landing"
  get "home", to: "insides#home", as: :user_root
  get "profil", to: "insides#profile", as: :profile
  get "pilih", to: "insides#choose", as: :choose
  post "/emailconfirmation", to: "insides#email", as: "email_confirmation"
  post "/subscribe", to: "insides#subscribe", as: "subscribe"
  post "/socialize", to: "insides#socialize", as: "socialize"
  get "/simulasi", to: "insides#simulation", as: "simulation"
  get '/change_locale/:locale', to: 'insides#change_locale', as: :change_locale

  get "/404" => "errors#not_found"
  get "/422" => "errors#unprocessable"
  get "/500" => "errors#internal_server_error"

  namespace :admin do
    root "base#index"
    get 'subscribers', to: "base#subscribers", as: :subscribers
    put 'whitelisting', to: "base#whitelisting", as: :whitelisting
    post 'send_email', to: "base#send_email", as: :send_email
    get 'inbox', to: "base#inbox", as: :inbox
    get 'events', to: "analytics#events", as: :events_analytics
    get 'visits', to: "analytics#visits", as: :visits_analytics
    resources :users
    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    resources :posts do
      member do
        put "remove_header"
      end
    end
    resources :documents do
      member do
        get "delete"
      end
    end
    resources :tenders, only: [:index, :edit, :update, :destroy]
    resources :bids, only: [:index, :edit, :update, :destroy]
    resources :houses, skip: [:show]
    resources :comments
  end

  # Vanity AB TESTING FRAMEWORK
  get '/vanity' =>'vanity#index'
  get '/vanity/participant/:id' => 'vanity#participant'
  post '/vanity/complete'
  post '/vanity/chooses'
  post '/vanity/reset'
  post '/vanity/add_participant'
  get '/vanity/image'


  get "/*id" => 'pages#show', as: :page, format: false
  root to: 'pages#show', id: 'landing'

  resources :users, only: :show, path: '' do
    resources :tenders, only: :show, path: ''
  end

end