require 'api_constraints'
require 'subdomain'

Fustal::Application.routes.draw do
  apipie
  mount Attachinary::Engine => "/attachinary"
  mount_griddler  
  # # only for temporary, for passing mandrill route test
  # get "/email_processor", to: proc { [200, {}, ["OK"]] }, as: "mandrill_head_test_request"

  devise_for :users, :controllers => { 
            :registrations => "registrations", 
            :omniauth_callbacks => "omniauth_callbacks" }
  devise_scope :user do
    get "/daftarbeta" => "devise/registrations#new"
    get "/masukbeta" => "devise/sessions#new"
  end

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

  namespace :firm, path: '/', constraints: { subdomain: 'dana' } do    
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

  # Static Pages
  root "pages#landing"
  get "home", to: "pages#home", as: :user_root
  get "tos", to: "pages#tos", as: :service_terms
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  post "/subscribe", to: "pages#subscribe", as: "subscribe"
  
  get "/404" => "errors#not_found"
  get "/422" => "errors#unprocessable"
  get "/500" => "errors#internal_server_error"

  namespace :admin do
    root "base#index"
    get 'analytics', to: "base#analytics", as: :analytics
    get 'subscribers', to: "base#subscribers", as: :subscribers
    put 'whitelisting', to: "base#whitelisting", as: :whitelisting
    get 'inbox', to: "base#inbox", as: :inbox
    resources :users
    resources :firms
    resources :teams, only: [:index, :show, :destroy]
    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    resources :posts
    resources :documents do
      member do
        get "delete"
      end
    end
    resources :tenders, only: [:index, :update]
  end

  namespace :enterprise do
    root "base#show"    
    # get "contact", to: "base#contact", as: "contact"
  end

end