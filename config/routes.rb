Rails.application.routes.draw do
  root 'home#index'

  resource :broadcasts
  resources :rooms do
    resources :comments
  end
  resources :users
end
