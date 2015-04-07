Rails.application.routes.draw do
  resources :clients

  resources :companies

  resources :invoices

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
end
