Rails.application.routes.draw do

  resources :earns

  get "token/index" => "token#index"

  get "profile/index"
  get "profile/my_model"
  match "profile/verify_invite_code", via: %i[get post]
  get "profile/verify_cancel"
  match "profile/verify_email", via: %i[get post]

  resources :order do
    collection do
      get :earn
      get :text_to
      get :picture_to
      get :createorder
    end
  end
  
  get 'metamask/eth/:address', to: 'metamask#eth'
  get "/auth_modal", to: "home#auth_modal"
  # devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }
  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
