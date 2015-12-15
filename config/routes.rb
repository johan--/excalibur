require 'api_constraints'
require 'subdomain'

Fustal::Application.routes.draw do
  # apipie
  if Rails.env.development?
    mount SubscriberPreview => 'subscriber_view'
  end
  mount Attachinary::Engine => "/attachinary"

  devise_for :users, :controllers => { 
            :registrations => "registrations", 
            :omniauth_callbacks => "omniauth_callbacks" }
  devise_scope :user do
    get "/daftarbeta" => "devise/registrations#new"
    get "/masukbeta" => "devise/sessions#new"
  end

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

  namespace :blog, path: '/', constraints: { subdomain: 'blog' } do
    get "find", to: "posts#find_posts", as: "find_posts"
    get "diskusi", to: "posts#discussion_room", as: "discussion"
    resources :posts do
    end
    get '' => "posts#index"
  end

  # namespace :firm, path: '/', constraints: { subdomain: 'dana' } do    
  namespace :firm, path: '/dana' do
    root "base#landing"
    get 'dashboard', to: "base#dashboard", as: :dashboard
    resources :bids
  end

# New App
  resources :users, only: [:show, :edit, :update] do
    member do
      get "avatar"
      put "remove_avatar"
    end    
    resources :tenders, only: [:new, :edit, :create, :update, :destroy]
  end
  resources :tenders, only: [:show] do
    resources :bids
  end
  resources :documents do
  end
  resources :deals, only: [:index, :show] do
    resources :term_sheets, only: [:index, :show]
  end

  # Static Pages
  root "pages#landing"
  get "ganti", to: "pages#upgrade", as: :upgrade
  get "home", to: "pages#home", as: :user_root
  get "tos", to: "pages#tos", as: :service_terms
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  post "/subscribe", to: "pages#subscribe", as: "subscribe"
  get "/simulasi", to: "pages#simulation", as: "simulation"
  # post "/simulasi", to: "pages#simulation", as: "simulation"
  get "klien", to: "pages#for_clients", as: :for_clients
  get "investor", to: "pages#for_investors", as: :for_investors
  get "developer", to: "pages#for_developers", as: :for_developers

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
    resources :tenders, only: [:index, :edit, :update]
    resources :bids, only: [:index, :edit, :update, :destroy]
    resources :deals, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    	resources :term_sheets, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  # Vanity AB TESTING FRAMEWORK
  get '/vanity' =>'vanity#index'
  get '/vanity/participant/:id' => 'vanity#participant'
  post '/vanity/complete'
  post '/vanity/chooses'
  post '/vanity/reset'
  post '/vanity/add_participant'
  get '/vanity/image'

end