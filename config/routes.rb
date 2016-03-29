require 'api_constraints'
require 'subdomain'

Fustal::Application.routes.draw do
  wiki_root '/wiki'
  # apipie

  mount SubscriberPreview => 'subscriber_view' if Rails.env.development?
  mount Attachinary::Engine => "/attachinary"

  devise_for :users, :controllers => { 
    :registrations => "registrations", :sessions => "sessions", 
    :passwords => "passwords", :omniauth_callbacks => "omniauth_callbacks" 
  }
  devise_scope :user do
    get "/daftarbeta" => "devise/registrations#new"
    get "/masukbeta" => "devise/sessions#new"
  end

  namespace :blog, path: '/', constraints: { subdomain: 'blog' } do
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
  resources :tenders, path: 'bursa' do
    member do
      get "discuss"
    end
    resources :build, only: [:show, :update], controller: 'tenders/build'
    resources :bids
  end
  resources :documents
  resources :houses, only: [:show, :index] do
    resources :tenders, only: :create
  end
  resources :comments
  resources :groups
  resources :invoices do
    resources :payments
  end

  # Static Pages
  root "pages#landing"
  get "ganti", to: "pages#upgrade", as: :upgrade
  
  get "home", to: "insides#home", as: :user_root
  # get "bursa", to: "insides#marketplace", as: :marketplace
  # get "pendanaan", to: "insides#choose", as: :choose_product
  get "profil", to: "insides#profile", as: :profile

  get "tos", to: "pages#tos", as: :service_terms
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  get "/prepare_request", to: "pages#prepare_request", as: "prepare_request"
  post "/send_request", to: "pages#send_request", as: "send_request"
  post "/subscribe", to: "pages#subscribe", as: "subscribe"
  get "/simulasi", to: "pages#simulation", as: "simulation"
  get "/buka_simulasi", to: "pages#open_simulation", as: "open_simulation"

  get "about", to: "pages#about_us", as: :about_us
  get "/kepemilikan", to: "pages#ownership", as: :ownership_job
  get "/investasi", to: "pages#funding", as: :funding_job
  get '/change_locale/:locale', to: 'pages#change_locale', as: :change_locale


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
    resources :users, skip: [:destroy]
    resources :firms
    resources :teams, only: [:index, :show, :destroy]
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
    resources :houses, skip: [:show] do
      member do
        get "upload", to: "houses#upload_photo", as: :upload_photo
      end
    end
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

  # namespace :api,  defaults: { format: :json }  do  
  #   scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
  #     resources :users, only: [:index, :show, :create, :update]
  #     resources :sessions, only: [:create, :destroy]
  #     resources :relationships, only: [:index, :show, :create, :destroy]
  #     resources :businesses, only: [:index, :show, :create, :update, :destroy]
  #     resources :tenders, only: [:index, :show, :create, :update, :destroy]
  #     resources :bids, only: [:index, :show, :create, :update, :destroy]
  #     resources :rosters, only: [:show, :create, :update, :destroy]
  #   end
  # end
end