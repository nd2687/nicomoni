Rails.application.routes.draw do
  root 'home#index'

  resource :session, only: [ :new, :create, :destroy ]
  resource :broadcasts
  resources :rooms, param: :url_token do
    resources :comments
  end
  resources :users
end
