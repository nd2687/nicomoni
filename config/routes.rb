Rails.application.routes.draw do
  root 'home#index'

  resource :session, only: [ :new, :create, :destroy ]
  resource :broadcasts
  resources :rooms, param: :url_token do
    delete :exit_room, on: :member
    post :broadcast_create, on: :member
    resources :comments
  end
  resources :users do
    get :edit_icon, on: :member
    patch :update_icon, on: :member
  end
end
