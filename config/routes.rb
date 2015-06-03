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

  # resources :firms do
  #   member do
  #     get "all_reservations"
  #     get "settings"
  #   end
  # end

  resources :subscriptions do
    resources :payments
  end

  resources :relationships, only: [:create, :destroy]
  root "pages#landing"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  
  get "posts", to: "pages#posts", as: "posts"
  get "posts/:id", to: "pages#show_post", as: "post"
  devise_for :users

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
    get "settings", to: "base#settings", as: :settings
    get "bookings", to: "base#bookings", as: :bookings
    resources :base, only: [:edit, :update]
  end

end
