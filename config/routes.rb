Rails.application.routes.draw do
  root 'home#index'

  resource :broadcasts, only: :show
end
