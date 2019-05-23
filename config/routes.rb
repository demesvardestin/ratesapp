Rails.application.routes.draw do

  # devise_for :brands, :controllers => { :registration => "brands/registration" }
  # devise_scope :brand do
  #   get '/brand/login', to: 'devise/sessions#new'
  #   get '/brand/signup', to: 'devise/registrations#new'
  #   get '/password-settings', to: 'users/registrations#edit'
  #   get '/retrieve-password', to: 'devise/passwords#new'
  # end
  # authenticated :brand do
  #   root 'brands#dashboard', as: :authenticated_brand_root
  # end
  
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    get '/signup', to: 'devise/registrations#new'
    get '/register', to: 'devise/registrations#new'
    get '/password/settings', to: 'users/registrations#edit'
    get '/retrieve/password', to: 'devise/passwords#new'
  end
  authenticated :user do
    root 'users#dashboard', as: :authenticated_user_root
  end
  resources :promos, except: [:show, :index, :new]
  resources :promo_requests, except: [:index]
  resources :users, only: [:update, :show]
  
  get '/:username', to: "users#show", as: "promoter"
  
  get '/request/mark_as_processed', to: 'promo_requests#mark_as_processed'
  get '/confirmation/receipt', to: 'promo_requests#receipt'
  get '/assets/download_image', to: 'promo_requests#download_image'
  get '/request/ship', to: 'promo_requests#ship_request'
  get '/request/receipt', to: 'promo_requests#receipt'
  post '/send_email', to: 'promo_requests#send_email'
  
  get '/account/settings', to: "users#edit"
  get '/promo/requests', to: "users#promo_requests"
  get '/requests/fetch_processed_requests', to: "promo_requests#processed"
  get '/requests/fetch_unprocessed_requests', to: "promo_requests#unprocessed"
  get '/requests/fetch_all_requests', to: 'promo_requests#all'
  get '/notifications/update_all_notifications', to: 'users#update_all_notifications'
  root 'welcome#home'
end
