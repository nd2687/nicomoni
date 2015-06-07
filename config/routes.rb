Rails.application.routes.draw do
  root 'home#index'

  resource :session, only: [ :new, :create, :destroy ]
  resource :broadcasts
  resources :rooms, param: :url_token do
    member do
      delete :exit_room
      post :broadcast_create
      patch :change_aspect
      patch :remove_broadcast
    end
    resources :comments
  end
  resources :users do
    member do
      get :edit_icon
      patch :update_icon
      get :friends
      get :followers
    end
    resources :friendships, only: [ :create, :destroy ]
  end
  resource :help
  resources :boards do
    resources :responses
  end
  get 'news' => 'news#index'
end
