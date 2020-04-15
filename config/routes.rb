Rails.application.routes.draw do
  root 'homepage#index'
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth' }
end
