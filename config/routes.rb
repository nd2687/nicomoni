Rails.application.routes.draw do
  root 'home#index'

  resource :session, only: [ :new, :create, :destroy ]
  resource :broadcasts
  resources :rooms do
    resources :comments
  end
  resources :users
end
