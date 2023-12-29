Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'
  get 'our_team', to: 'pages#our_team'
  get 'contact_support', to: 'pages#contact_support'

  get "sign_in_customer", to: "sessions#new"
  post "sign_in_customer", to: "sessions#create"
  get 'auth/google_oauth2/callback', to: 'sessions#create_via_google'

  delete "logout_customer", to: "sessions#destroy"

  resources :customers
  resources :hostes

  get "sign_in_host", to: "sessions_host#new"
  post "sign_in_host", to: "sessions_host#create"

  delete "logout_host", to: "sessions_host#destroy"

  

  resources :bookings

  resources :vehicles
end
