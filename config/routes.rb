Rails.application.routes.draw do
  resources :profiles
  devise_for :users

  get 'all_users', to: 'profiles#all_users', as: :all_users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  resources :profiles do
    member do
      put :update_role
    end
  end

  root "home#index"
  resources :bridges, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
    resources :instance_bridges, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  end
  get 'your_bridges', to: 'bridges#your_bridges', as: :your_bridges
  get 'upload_bridge', to: 'bridges#upload_bridge', as: :upload_bridge
  post 'send_upload_bridge', to: 'bridges#send_upload_bridge', as: :send_upload_bridge

  get "dashboard", to: "dashboard#index" 

  scope module: :bridges, path: :bridges, as: :bridge do
    resources :publish, only: :update
    resources :unpublish, only: :update
  end

  resources :activity_logs, only: [:index]

end
