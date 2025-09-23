Rails.application.routes.draw do
  get "matches/index"
  get "matches/show"
  get "matches/new"
  get "matches/edit"
  get "matches/_form"
  devise_for :users

   authenticated :user do
    root to: "users#show", as: :authenticated_root
  end
  unauthenticated :user do
    devise_scope :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  get "mypage", to: "users#show"

  resources :matches
  get "stats", to: "stats#index", as: :stats

#この下2行の先頭に＃がついていることで、shareにアクセス不可にしている。
  #resources :shares do
     #resources :comments, only: [:create]
  #end

  root 'matches#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  
end
