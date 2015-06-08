Fustal::Application.routes.draw do
  
  resources :reservations, skip: [:show, :index] do
    member do
      put "confirm" => "reservations#confirm", as: :confirm
    end
  end
  resources :installments
  
  resources :venues do
    member do
      get "bookings" => "venues#bookings", as: :bookings
    end
    resources :courts
  end

  resources :courts do
    resources :reservations, skip: [:new, :create, :edit, :update]
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

  devise_for :users, :controllers => { :registrations => "registrations" }

  namespace :admin do
    root "base#index"
    resources :users
    resources :firms, only: [:index]
    get "posts/drafts", to: "posts#drafts", as: "posts_drafts"
    get "posts/dashboard", to: "posts#dashboard", as: "posts_dashboard"
    resources :posts
  end

  namespace :biz do
    root "base#show"
    get "management", to: "base#management", as: :management
    get "settings", to: "base#settings", as: :settings
    put "save_settings", to: "base#save_settings", as: :save_settings
    post "subscribes", to: "base#subscribes", as: :subscribes
    get "bookings", to: "base#bookings", as: :bookings
    # resources :base, only: [:edit, :update]
    get "edit_bio", to: "base#edit_bio", as: :edit_bio
    put "update_bio", to: "base#update_bio", as: :update_bio
    resources :rosters

    get "subscription", to: "base#subscription", as: :subscription
    get "expiration", to: "base#expiration", as: :expiration
    
    resources :payments, skip: :destroy
  end

end
