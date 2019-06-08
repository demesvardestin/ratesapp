Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  devise_scope :user do
    get '/login', to: 'devise/sessions#new'
    get '/signup', to: 'devise/registrations#new'
    get '/register', to: 'devise/registrations#new'
    get '/password/settings', to: 'users/registrations#edit'
    get '/retrieve/password', to: 'devise/passwords#new'
  end
  authenticated :user do
    root 'users#promo_requests', as: :authenticated_user_root
  end
  resources :promos, except: [:show, :index, :new]
  resources :promo_requests, except: [:index]
  resources :users, only: [:update, :show]
  resources :help_tickets, only: :create
  
  get '/:username', to: "users#show", as: "promoter"
  
  get '/request/mark_as_processed', to: 'promo_requests#mark_as_processed'
  get '/confirmation/receipt', to: 'promo_requests#receipt'
  get '/assets/download_image', to: 'promo_requests#download_image'
  get '/request/ship', to: 'promo_requests#ship_request'
  get '/request/receipt', to: 'promo_requests#receipt'
  get '/request/payment', to: 'promo_requests#payment'
  post '/request/pay', to: 'promo_requests#pay'
  post '/stripe_callback', to: 'users#stripe_callback'
  get '/account/rates', to: 'users#dashboard'
  
  post '/submit_help_ticket', to: 'welcome#submit_help_ticket'
  post '/set_payout_method', to: 'users#set_payout_method'
  get '/pages/help', to: 'welcome#help'
  get '/pages/terms', to: 'welcome#terms'
  get '/pages/privacy', to: 'welcome#privacy'
  post '/account/set_email_preferences', to: 'users#set_email_preferences'
  get '/account/settings', to: "users#edit"
  get '/account/payouts', to: "users#payouts"
  get '/account/analytics', to: "users#analytics"
  post '/add_stripe_account', to: 'users#add_stripe_account'
  get '/promo/requests', to: "users#promo_requests"
  get '/requests/fetch_processed_requests', to: "promo_requests#processed"
  get '/requests/fetch_unprocessed_requests', to: "promo_requests#unprocessed"
  get '/requests/fetch_all_requests', to: 'promo_requests#all'
  get '/notifications/update_all_notifications', to: 'users#update_all_notifications'
  root 'welcome#home'
  
end
