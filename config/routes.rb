Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  root "home#index"
  resources :bridges, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
    resources :instance_bridges, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  end
  get 'your_bridges', to: 'bridges#your_bridges', as: :your_bridges

  get "dashboard", to: "dashboard#index" 

  scope module: :bridges, path: :bridges, as: :bridge do
    resources :publish, only: :update
    resources :unpublish, only: :update
  end

  resources :activity_logs, only: [:index]

end
