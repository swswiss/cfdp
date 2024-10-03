Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # # Render dynamic PWA files from app/views/pwa/*
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
  resources :bridges, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  get 'your_bridges', to: 'bridges#your_bridges', as: :your_bridges

  get "dashboard", to: "dashboard#index" 

  scope module: :bridges, path: :bridges, as: :bridge do
    resources :publish, only: :update
    resources :unpublish, only: :update
  end

end
