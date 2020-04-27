Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  root 'homepage#index'

  get 'documents'  => 'documents#index'
  post 'documents' => 'documents#create'

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth' }

  resources :budgets
  resources :expenses
  resources :incomes

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
