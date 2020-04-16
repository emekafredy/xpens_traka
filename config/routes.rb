Rails.application.routes.draw do
  resources :expenses
  resources :incomes
  root 'homepage#index'
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth' }
end
