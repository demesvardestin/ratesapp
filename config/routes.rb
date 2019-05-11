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
    get '/password-settings', to: 'users/registrations#edit'
    get '/retrieve-password', to: 'devise/passwords#new'
  end
  authenticated :user do
    root 'users#show', as: :authenticated_user_root
  end
  
  resources :comments, except: [:show, :index, :new]
  resources :promos, except: [:show, :index, :new]
  resources :promo_requests, except: [:index]
  
  resources :users, only: [:show, :update] do
    resources :promos, only: [:index]
  end
  
  # namespace :ig do
  get '/:username', to: "users#show"
  # end
  
  get '/update_notification_watcher', to: 'ig/users#update_notification_watcher'
  get '/update_all_notifications', to: 'ig/users#update_all_notifications'
  get '/confirmation/receipt', to: 'promo_requests#receipt'
  
  get '/account/payouts', to: "users#payouts"
  get '/account/settings', to: "users#edit"
  get '/promo/requests', to: "users#promo_requests"
  # get "/oauth/connect/:username", to: 'users#auth_connect'
  # get "/oauth/callback", to: 'users#auth_callback'
  
  root 'welcome#home'
end
