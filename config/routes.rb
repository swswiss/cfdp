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

  resources :bridges do
    member do
      get :print
    end
  end

  get '/contact', to: 'pages#contact'
  get '/donations', to: 'pages#donations'
  get '/legends', to: 'pages#legends'

  resources :user_integrations, only: [:index] do
    collection do
      put :update_integrations # Add this line for the new action
    end
  end

  get 'custom', to: 'bridges#custom', as: :custom

  root "home#index"
  resources :bridges, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
    post 'compare_data', on: :member
    member do
      post 'clone'
    end
    resources :instance_bridges, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
      member do
        get :print
      end
    end
  end
  get 'your_bridges', to: 'bridges#your_bridges', as: :your_bridges
  get 'comparison', to: 'bridges#comparison', as: :comparison
  get 'upload_bridge', to: 'bridges#upload_bridge', as: :upload_bridge
  post 'send_upload_bridge', to: 'bridges#send_upload_bridge', as: :send_upload_bridge

  get "dashboard", to: "dashboard#index" 

  scope module: :bridges, path: :bridges, as: :bridge do
    resources :publish, only: :update
    resources :unpublish, only: :update
  end

  resources :activity_logs, only: [:index]

end
