Rails.application.routes.draw do
  root 'homepage#index'

  get 'documents'  => 'documents#index'
  post 'documents' => 'documents#create'

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth' }

  resources :budgets
  resources :expenses
  resources :incomes
end
