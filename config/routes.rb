require 'api_constraints'
require 'subdomain'

Fustal::Application.routes.draw do
  apipie
  mount Judge::Engine => '/judge'  
  
  devise_for :users, :controllers => { :registrations => "registrations", 
                            :omniauth_callbacks => "omniauth_callbacks" }

  # namespace :api, :path => '/', constraints: { subdomain: 'api' },  defaults: { format: :json }  do  
  namespace :api,  defaults: { format: :json }  do  
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:index, :show, :create, :update]
      resources :sessions, only: [:create, :destroy]
      resources :reservations, except: [:edit, :new]
      resources :relationships, only: [:index, :show, :create, :destroy]
      resources :venues, except: [:new, :edit, :destroy]
      resources :courts, except: [:new, :edit, :destroy]
      resources :firms, except: [:new, :edit, :destroy]
      resources :installments, except: [:index, :new, :edit, :destroy]
    end
  end 

  resources :reservations, except: [:new, :destroy]
  resources :installments, except: :destroy do
    member do
      get "veritrans_checkout" => "installments#veritrans_checkout", as: :veritrans_checkout
    end    
  end
  
  resources :venues, only: [:index, :show] do
    member do
      get "bookings" => "venues#bookings", as: :bookings
    end
  end

  resources :firms, only: [:index, :new, :create] do
    member do
      post "join" => "firms#join", as: :join
    end
  end

  resources :relationships, only: [:create, :destroy]
  root "pages#landing"
  get "home", to: "pages#home", as: :user_root
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  
  get "posts", to: "pages#posts", as: "posts"
  get "posts/:id", to: "pages#show_post", as: "post"

  namespace :admin do
    root "base#index"
    resources :users
    resources :firms, only: [:index]
    resources :reservations, only: [:index]
    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    get "posts/dashboard", to: "posts#dashboard", as: "posts_dashboard"
    resources :posts
  end

  # namespace :biz do
  #   root "base#show"
  #   post "subscribes", to: "base#subscribes", as: :subscribes
  #   get "management", to: "base#management", as: :management
  #   get "settings", to: "base#settings", as: :settings
  #   put "save_settings", to: "base#save_settings", as: :save_settings
    
  #   get "view", to: "base#view", as: :view
  #   put "confirm" => "base#confirm", as: :confirm
    
  #   get "edit_bio", to: "base#edit_bio", as: :edit_bio
  #   put "update_bio", to: "base#update_bio", as: :update_bio
  #   resources :rosters

  #   get "subscription", to: "base#subscription", as: :subscription
  #   get "expiration", to: "base#expiration", as: :expiration
    
  #   get "contact", to: "base#contact", as: "contact"

  #   resources :payments, except: :destroy
  #   resources :venues, except: :destroy do
  #     get "bookings", to: "venues#bookings", as: :bookings

  #     resources :courts, except: :destroy do
  #       member do
  #         get 'preferences'=> "courts#preferences", as: :preferences
  #         put "save_preferences", to: "courts#save_preferences", as: :save_preferences
  #       end
  #     end
  #   end

  # end

end
